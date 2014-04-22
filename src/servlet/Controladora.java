package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.LoginBean;

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
		case "novoUsuario":

			break;
		case "atualizarUsuario":

			break;

		default:
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
