package model;

import java.math.BigDecimal;

import bean.UsuarioBean;
import br.com.uol.pagseguro.domain.PaymentRequest;
import br.com.uol.pagseguro.domain.Transaction;
import br.com.uol.pagseguro.enums.Currency;
import br.com.uol.pagseguro.enums.DocumentType;
import br.com.uol.pagseguro.exception.PagSeguroServiceException;
import br.com.uol.pagseguro.properties.PagSeguroConfig;
import br.com.uol.pagseguro.service.TransactionSearchService;

public class Pagamento {
	public String enviaPagSeguro(Carrinho carrinho, UsuarioBean usuario){			
		
		
		PaymentRequest paymentRequest = new PaymentRequest();  
		
		for (ItemCarrinho item : carrinho.getListaItens()) {
			paymentRequest.addItem(  
					  Integer.toString(item.getProduto().getId()), // Identificação em seu sistema  
					  item.getProduto().getNome(), // Descrição  
					  item.getQuantidade(), // Quantidade  					
					  new BigDecimal(Double.toString(item.getPreco())), // Valor unitário  
					  new Long(100), // Peso unitário, em gramas  
					  new BigDecimal("0.00") // Valor unitário do frete  
					); 
		}
	
	
		paymentRequest.setShippingCost(new BigDecimal("30.00"));  
		
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
				paymentRequest.setReference("REF1234-USER214-ORDER754851B");  
				  
				// URL para onde o comprador será redirecionado (GET) após o fluxo de pagamento  
				paymentRequest.setRedirectURL("http://www.lojamodelo.com.br/thankyou");  
			
				String response = null;
				try {  
					  
					  boolean onlyCheckoutCode = false;  
					  response = paymentRequest.register(PagSeguroConfig.getAccountCredentials(), onlyCheckoutCode);  
					  
					  System.out.println(response);  
					  
					} catch (PagSeguroServiceException e) {  
					  
					    System.err.println(e.getMessage());  
					}  
		
		return response;		
	}
	
	public void recebePagSeguro(String transactionCode){		

		Transaction transaction = null;  
		  
		try {  
		  
		    transaction = TransactionSearchService.searchByCode(PagSeguroConfig.getAccountCredentials(),  
		            transactionCode);  
		  
		} catch (PagSeguroServiceException e) {  
		    System.err.println(e.getMessage());  
		}  
		  
		if (transaction != null) {  
		  System.out.println("reference: " + transaction.getReference());  
		  System.out.println("status: " + transaction.getStatus());  
		}  
		
	}
}
