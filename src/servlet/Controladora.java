package servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;

import util.FormUtil;
import bean.CategoriaBean;
import bean.LoginBean;
import bean.ProdutoBean;
import bean.UsuarioBean;
import dao.CategoriaDAO;
import dao.ProdutoDAO;
import dao.UsuarioDAO;

/**
 * Servlet implementation class Controladora
 */
@WebServlet("/Controladora")
@MultipartConfig
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
		
		String path = getServletContext().getRealPath("/");
		
		//carrega categorias, etc
		carregarObjetosComuns(request, response);
		

		switch (action) {
		case "login":

			loginBean = FormUtil.populate(LoginBean.class,request);	

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
			
			CategoriaDAO categoriaDao = null;
			try {
				categoriaDao = new CategoriaDAO();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			CategoriaBean categoria = FormUtil.populate(CategoriaBean.class,request);					
			
			if (request.getParameter("atualizar") != null)
				try {
					categoriaDao.gravar(categoria, true);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else if (request.getParameter("novo") != null)
				try {
					categoriaDao.gravar(categoria, false);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			else if (request.getParameter("deletar") != null)
				try {
					categoriaDao.deletar(categoria.getId());
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
			
			UsuarioBean usuario = FormUtil.populate(UsuarioBean.class,request);	
			
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
			
			UsuarioBean usuarioNovo = FormUtil.populate(UsuarioBean.class,request);
			
			loginBean = (LoginBean) session.getAttribute("loginBean");				


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
			
			
			
		case"produto":
			
			ProdutoDAO produtoDao = null;
			try {
				produtoDao = new ProdutoDAO();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ProdutoBean produto = FormUtil.populate(ProdutoBean.class,request);
			Part filePart = null;
			
			if (request.getParameter("atualizar") != null){				
	
				try {
					filePart = request.getPart("imagem"); // Retrieves <input type="file" name="file">
				    String filename = getFilename(filePart);
				    produto.setExtencao(FilenameUtils.getExtension(filename));
				    
				    
					produtoDao.gravar(produto, true);
					
					
				    
				    InputStream filecontent = filePart.getInputStream();	    					
				    OutputStream os = new FileOutputStream(path + produto.getImagemURL());		
				    
				    IOUtils.copy(filecontent, os);

				    filecontent.close();
					os.close();		
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if (request.getParameter("novo") != null){
				try {
					
					filePart = request.getPart("imagem"); // Retrieves <input type="file" name="file">
				    String filename = getFilename(filePart);
				    produto.setExtencao(FilenameUtils.getExtension(filename));
					
					produtoDao.gravar(produto, false);	
					
				    
				    InputStream filecontent = filePart.getInputStream();	    					
				    OutputStream os = new FileOutputStream(path + produto.getImagemURL());		
				    
				    IOUtils.copy(filecontent, os);

				    filecontent.close();
					os.close();		
					
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}
			else if (request.getParameter("deletar") != null){
				try {
					produtoDao.deletar(produto.getId());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}
			
			//atualiza imagem
			if(request.getParameter("atualizar") != null || request.getParameter("novo") != null){	
				
			}else if(request.getParameter("deletar") != null){
				Files.deleteIfExists(Paths.get(produto.getImagemURL()));
			}

			response.sendRedirect(request.getHeader("Referer"));
			
			break;
			
			
			
			
		case "index":
			
			ProdutoDAO produtoDAO = null;
			try {
				produtoDAO = new ProdutoDAO();
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			List<ProdutoBean> listaDestaque = null;
			try {
				listaDestaque = produtoDAO.carregarTodos();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			request.setAttribute("listaDestaque", listaDestaque);
			
			forward(request, response, "../index.jsp");			
			
			break;
			
		case "conta":
			
			forward(request, response, "../conta.jsp");	
			break;
			
		case "carrinho":
			
			
			forward(request, response, "../carrinho.jsp");	
			break;
			
		case "quemsomos":
			
			forward(request, response, "../quemsomos.jsp");	
			break;
			
		case "contato":
			
			forward(request, response, "../contato.jsp");	
			break;
			
		case "admin":
			
			
			forward(request, response, "../admin.jsp");	
			break;
			
		case "novaconta":
			
			forward(request, response, "../novaconta.jsp");			
			break;

		default:
			response.sendRedirect("../erro.jsp");
			break;
		}
		
	}

	private void carregarObjetosComuns(HttpServletRequest request,
			HttpServletResponse response) {
		
		CategoriaDAO categoriaDAO = null;
		try {
			categoriaDAO = new CategoriaDAO();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<CategoriaBean> listaCategorias = null;
		try {
			listaCategorias = categoriaDAO.carregarTodos();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("listaCategorias", listaCategorias);
		
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
	
	private static String getFilename(Part part) {
	    for (String cd : part.getHeader("content-disposition").split(";")) {
	        if (cd.trim().startsWith("filename")) {
	            String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
	            return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
	        }
	    }
	    return null;
	}
	
	private void forward(HttpServletRequest request, HttpServletResponse response,String path){
		RequestDispatcher rd = request.getRequestDispatcher(path);
		  try {
			rd.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
