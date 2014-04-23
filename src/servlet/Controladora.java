package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CategoriaDAO;
import dao.UsuarioDAO;
import bean.CategoriaBean;
import bean.LoginBean;
import bean.UsuarioBean;

/**
 * Servlet implementation class Controladora
 */
@WebServlet("/Controladora")
public class Controladora extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controladora() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{

		String action = request.getParameter("action");

		HttpSession session = request.getSession();

		LoginBean loginBean;
		
		UsuarioDAO usuarioDAO = null;

		switch (action) {
		case "login":

			loginBean = new LoginBean();
			loginBean.setEmail(request.getParameter("email"));
			loginBean.setSenha(request.getParameter("senha"));

			if (loginBean.autenticar()) {
				System.out.println("Usuario logando:" + loginBean.getEmail());
				session.setAttribute("loginBean", loginBean);
				response.sendRedirect(request.getHeader("Referer"));
			} else {
				response.sendRedirect("../index.jsp");
			}

			break;
		case "logout":			
			
			loginBean = (LoginBean) session.getAttribute("loginBean");
			if (session != null) {
				if (loginBean != null) {
					System.out.println("Usuario deslogado:"
							+ loginBean.getEmail());
				}
				session.invalidate();				
			}
			response.sendRedirect("../index.jsp");

			break;
			
		case"categoria":
			
			CategoriaDAO dao = null;
			try {
				dao = new CategoriaDAO();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			CategoriaBean categoria = new CategoriaBean();
			
			categoria.setNome(request.getParameter("nome"));		
			
			
			if (request.getParameter("atualizar") != null)
				try {
					dao.gravar(categoria, true);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else if (request.getParameter("novo") != null)
				try {
					dao.gravar(categoria, false);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else if (request.getParameter("deletar") != null)
				try {
					dao.deletar(categoria.getId());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			response.sendRedirect(request.getHeader("Referer"));
			
			break;
		case "novoUsuario":
			
			usuarioDAO = null;
			try {
				usuarioDAO = new UsuarioDAO();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			UsuarioBean usuario = new UsuarioBean();
			
			usuario.setNome(request.getParameter("nome"));
			usuario.setEmail(request.getParameter("email"));			
			usuario.setCpf(request.getParameter("cpf"));
			usuario.setCnpj(request.getParameter("cnpj"));
			usuario.setCep(request.getParameter("cep"));
			usuario.setCidade(request.getParameter("cidade"));
			usuario.setEstado(request.getParameter("estado"));
			usuario.setRua(request.getParameter("rua"));
			usuario.setNumero(request.getParameter("numero"));
			usuario.setTelefone1(request.getParameter("telefone1"));
			usuario.setTelefone2(request.getParameter("telefone2"));
			
			usuario.setSenha(request.getParameter("senha"));			
			
			try {
				usuarioDAO.gravar(usuario,false);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}	
			response.sendRedirect(request.getHeader("Referer"));

			break;
		case "atualizarUsuario":

			usuarioDAO = null;
			try {
				usuarioDAO = new UsuarioDAO();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			UsuarioBean usuarioNovo = new UsuarioBean();
			
			loginBean = (LoginBean) session.getAttribute("loginBean");	
			
			usuarioNovo.setId(Integer.valueOf(request.getParameter("id")));
			usuarioNovo.setNome(request.getParameter("nome"));
			usuarioNovo.setEmail(request.getParameter("email"));			
			usuarioNovo.setCpf(request.getParameter("cpf"));
			usuarioNovo.setCnpj(request.getParameter("cnpj"));
			usuarioNovo.setCep(request.getParameter("cep"));
			usuarioNovo.setCidade(request.getParameter("cidade"));
			usuarioNovo.setEstado(request.getParameter("estado"));
			usuarioNovo.setRua(request.getParameter("rua"));
			usuarioNovo.setNumero(request.getParameter("numero"));
			usuarioNovo.setTelefone1(request.getParameter("telefone1"));
			usuarioNovo.setTelefone2(request.getParameter("telefone2"));
			

			// Para não mandar o booleano de administrador pelo form
			usuarioNovo.setAdministrador(loginBean.getUsuario().isAdministrador());
			
			try {
				usuarioDAO.gravar(usuarioNovo,true);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			loginBean.setUsuario(usuarioNovo);
			response.sendRedirect(request.getHeader("Referer"));
			
			break;

		default:
			response.sendRedirect("../erro.jsp");
			break;
		}
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {		
		processRequest(request, response); 
	}
}
