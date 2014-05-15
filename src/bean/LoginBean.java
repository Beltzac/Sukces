package bean;

import dao.UsuarioDAO;


public class LoginBean {
	private String email;
	private String senha;
	private UsuarioBean usuario;
	private boolean autenticado;

	public boolean autenticar() {
		
		if (email != null && senha != null){
			
			try {
				UsuarioDAO dao = new UsuarioDAO();
				UsuarioBean alvo = dao.carregar(email,senha);
				
				System.out.println(alvo.toString());
				
				if (alvo != null){
					usuario = alvo;
					autenticado = true;
					return true;		
				}
				
			} catch (Exception e) {				
				e.printStackTrace();
			}	
		}
		return false;
	}

	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}


	public boolean isAutenticado() {
		return autenticado;
	}

	public void setAutenticado(boolean autenticado) {
		this.autenticado = autenticado;
	}

	public UsuarioBean getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioBean usuario) {
		this.usuario = usuario;
	}
}