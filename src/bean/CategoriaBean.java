package bean;

import java.io.Serializable;

public class CategoriaBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String nome;


	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "CategoriaBean [id=" + id + ", nome=" + nome + "]";
	}


	
	
	
}