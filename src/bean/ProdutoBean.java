package bean;

import java.io.Serializable;

public class ProdutoBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String nome;
	private int categoria;
	private double preco;
	private String descricao;
	private String extencao;
	private String data_criacao;
	private String localImagem = "imagensProdutos";
	
 	@Override
	public String toString() {
		return "ProdutoBean [id=" + id + ", nome=" + nome + ", categoria="
				+ categoria + ", valor=" + preco + ", descricao=" + descricao
				+ ", data_criacao=" + data_criacao + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public int getCategoria() {
		return categoria;
	}
	public void setCategoria(int categoria) {
		this.categoria = categoria;
	}
	public double getPreco() {
		return preco;
	}
	public void setPreco(double valor) {
		this.preco = valor;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public String getData_criacao() {
		return data_criacao;
	}
	public void setData_criacao(String data_criacao) {
		this.data_criacao = data_criacao;
	}
	
	public String getImagemURL() {
		return localImagem +"/" +id + "." + extencao;
	}
	
	public String getExtencao() {
		return extencao;
	}
	public void setExtencao(String extencao) {
		this.extencao = extencao;
	}
	public String getLocalImagem() {
		return localImagem;
	}
	public void setLocalImagem(String localImagem) {
		this.localImagem = localImagem;
	}
	
	

	
	
}