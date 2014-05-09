package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Map.Entry;

import bean.ProdutoBean;

public class Carrinho implements Serializable {

	private static final long serialVersionUID = 1L;

	private Hashtable<Integer, ItemCarrinho> lista = new Hashtable<>();

	public void adicionaProduto(ProdutoBean produto, int quantidade) {
		if (!lista.containsKey(produto.getId())) {
			ItemCarrinho item = new ItemCarrinho();
			item.setProduto(produto);
			item.setPreco(produto.getPreco());			
			item.setQuantidade(quantidade);
			lista.put(produto.getId(), item);
		} else {
			ItemCarrinho i = lista.get(produto.getId());
			i.setQuantidade(i.getQuantidade() + quantidade);
		}
	}

	public void removeProduto(int idProduto) {
		lista.remove(idProduto);
	}

	public Hashtable<Integer, ItemCarrinho> getLista() {
		return lista;
	}
	
	public ArrayList<ItemCarrinho> getListaItens() {
		return new ArrayList<ItemCarrinho>(lista.values());
	}
	
	public double getTotal(){
		double total = 0;
		for(Entry<Integer, ItemCarrinho> entry : lista.entrySet()) {
		    total += entry.getValue().getTotal();
		}		
		return total;
	}
	
	public int getQuantidadeItensUnicos(){				
		return lista.size();
	}

}
