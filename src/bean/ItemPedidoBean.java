package bean;

import java.io.Serializable;

public class ItemPedidoBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private double valor;
	private int quantidade;
	private int produto;
	private String imagem;
	private String comentarios;
	
	public double getTotal(){
		return quantidade * valor;
	}

	@Override
	public String toString() {
		return "itemPedidoBean [id=" + id + ", valor=" + valor + ", quantidade="
				+ quantidade + ", produto=" + produto + ", imagem=" + imagem
				+ ", comentarios=" + comentarios + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public int getProduto() {
		return produto;
	}
	public void setProduto(int produto) {
		this.produto = produto;
	}
	public String getImagem() {
		return imagem;
	}
	public void setImagem(String imagem) {
		this.imagem = imagem;
	}
	public String getComentarios() {
		return comentarios;
	}
	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}

	
	
	
}