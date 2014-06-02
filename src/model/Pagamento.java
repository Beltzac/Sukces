package model;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;

import bean.UsuarioBean;
import br.com.uol.pagseguro.domain.PaymentRequest;
import br.com.uol.pagseguro.domain.Transaction;
import br.com.uol.pagseguro.enums.Currency;
import br.com.uol.pagseguro.enums.DocumentType;
import br.com.uol.pagseguro.enums.TransactionStatus;
import br.com.uol.pagseguro.exception.PagSeguroServiceException;
import br.com.uol.pagseguro.properties.PagSeguroConfig;
import br.com.uol.pagseguro.service.TransactionSearchService;

public class Pagamento {
	public String enviaPagSeguro(Carrinho carrinho, UsuarioBean usuario,String transactionCode) throws PagSeguroServiceException{		
		System.out.println("Acessando pagseguro...");
		
		
		PaymentRequest paymentRequest = new PaymentRequest();  
		
		for (ItemCarrinho item : carrinho.getListaItens()) {
			double d = item.getPreco();
			NumberFormat formatter = new DecimalFormat("#,##");  
			//formatter.setMaximumFractionDigits(2);  
			//formatter.setMinimumFractionDigits(2);  
	        String dou = formatter.format(d);
	        BigDecimal big = new BigDecimal(d);
	        big = big.setScale(2);
	        dou = big.toString();
	        System.out.println(big);
	        //System.out.println(dou);
			paymentRequest.addItem(  
					  Integer.toString(item.getProduto().getId()), // Identificação em seu sistema  
					  item.getProduto().getNome(), // Descrição  
					  item.getQuantidade(), // Quantidade  					
					  new BigDecimal(dou), // Valor unitário  
					  new Long(100), // Peso unitário, em gramas  
					  new BigDecimal("0.50") // Valor unitário do frete  
					); 
		}
		
		
	
		paymentRequest.setShippingCost(new BigDecimal("10.00"));  
		
		paymentRequest.setSender(  
				  usuario.getNome(), // Nome completo  
				  usuario.getEmail(), // email  
				  null, // DDD  
				  null, // Telefone  
				  DocumentType.CPF, // Tipo de documento  
				  usuario.getCpf()// Número do documento  
				);  
			

		paymentRequest.setCurrency(Currency.BRL);
				
		// Referenciando a transação do PagSeguro em seu sistema  
		paymentRequest.setReference(transactionCode);  
				  
		// URL para onde o comprador será redirecionado (GET) após o fluxo de pagamento  
		paymentRequest.setRedirectURL("http://www.lojamodelo.com.br/thankyou");  
			
		String response = null;
				
					  
		boolean onlyCheckoutCode = false;  
		response = paymentRequest.register(PagSeguroConfig.getAccountCredentials(), onlyCheckoutCode);
		return response;		
	}
	
	public boolean recebePagSeguro(String transactionCode) throws PagSeguroServiceException{		
		System.out.println("Consultando pagseguro...");
		Transaction transaction = null;
		transaction = TransactionSearchService.searchByCode(PagSeguroConfig.getAccountCredentials(), transactionCode);  
		if (transaction != null) {  
		  System.out.println("reference: " + transaction.getReference());  
		  System.out.println("status: " + transaction.getStatus());  
		  
		  if(transaction.getStatus() == TransactionStatus.AVAILABLE){
			  return true;
		  }
		  
		}  
		return false;		
	}
	
	public String MD5(String md5) {
		   try {
		        java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
		        byte[] array = md.digest(md5.getBytes());
		        StringBuffer sb = new StringBuffer();
		        for (int i = 0; i < array.length; ++i) {
		          sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3));
		       }
		        return sb.toString();
		    } catch (java.security.NoSuchAlgorithmException e) {
		    }
		    return null;
		}
	
	public String createTransactionCode(UsuarioBean u){		
		String code  = "SUK-" + MD5("" + u.getId() + System.currentTimeMillis()).toUpperCase();
		System.out.println(code);
		return code;
	}
}
