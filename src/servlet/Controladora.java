package servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
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
	}
	
	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{

		String action = request.getParameter("action");
		String sub = request.getParameter("sub");

		HttpSession session = request.getSession();

		LoginBean loginBean;
		
		UsuarioDAO usuarioDAO = null;
		ProdutoDAO produtoDAO = null;
		
		String path = getServletContext().getRealPath("/");

		//carrega categorias, etc
		carregarObjetosComuns(request, response);
		
		
		if (action == null){
			forward(request, response, "/index.jsp");		
		}else
		switch (action) {
		case "login":

			loginBean = FormUtil.populate(LoginBean.class,request);	

			if (loginBean.autenticar()) {
				System.out.println("Usuario logando:" + loginBean.getEmail());
				session.setAttribute("loginBean", loginBean);
				response.sendRedirect(request.getHeader("Referer"));
			} else {
				paginaErro(request, response, "Login e/ou senha incorretos", null);
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
			response.sendRedirect("Controladora");

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
					e.printStackTrace();
					paginaErro(request, response, "Erro ao atualizar a categoria", e.getMessage());	
				}
			else if (request.getParameter("novo") != null)
				try {
					categoriaDao.gravar(categoria, false);
				} catch (Exception e) {					
					e.printStackTrace();
					paginaErro(request, response, "Erro ao cadastrar a categoria", e.getMessage());	
				}
			else if (request.getParameter("deletar") != null)
				try {
					categoriaDao.deletar(categoria.getId());
				} catch (Exception e) {					
					e.printStackTrace();
					paginaErro(request, response, "Erro ao deletar a categoria", e.getMessage());		
				}

			response.sendRedirect("Controladora?action=admin&sub=categoria");	
			
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
				e1.printStackTrace();
				paginaErro(request, response, "Erro ao cadastrar sua conta", e1.getMessage());				
			}	
			
			response.sendRedirect("Controladora");			

			break;
		case "atualizarUsuario":

			usuarioDAO = null;
			try {
				usuarioDAO = new UsuarioDAO();
			} catch (Exception e) {
				// todo auto-generated catch block
				e.printStackTrace();
			}
			
			UsuarioBean usuarioNovo = FormUtil.populate(UsuarioBean.class,request);
			
			loginBean = (LoginBean) session.getAttribute("loginBean");				


			// Para não mandar o booleano de administrador pelo form
			usuarioNovo.setAdministrador(loginBean.getUsuario().isAdministrador());
			
			try {
				usuarioDAO.gravar(usuarioNovo,true);
			} catch (Exception e) {
				e.printStackTrace();
				paginaErro(request, response, "Erro ao atualizar sua conta", e.getMessage());					
			}	
			loginBean.setUsuario(usuarioNovo);
			response.sendRedirect(request.getHeader("Referer"));		
			
			break;
			
		case "atualizarUsuarioAdmin":

			usuarioDAO = null;
			try {
				usuarioDAO = new UsuarioDAO();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			UsuarioBean usuarioAdmin = FormUtil.populate(UsuarioBean.class,request);
			
			try {
				usuarioDAO.gravar(usuarioAdmin,true);
			} catch (Exception e) {				
				e.printStackTrace();
				paginaErro(request, response, "Erro ao atualizar a conta do usuario", e.getMessage());	
			}	
			
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
					filePart = request.getPart("imagem"); 
				   
				    
				    if(filePart != null){
					    String filename = getFilename(filePart);
					    produto.setExtencao(FilenameUtils.getExtension(filename));
					    
					    
						produtoDao.gravar(produto, true);					
						
					    
					    InputStream filecontent = filePart.getInputStream();	    					
					    OutputStream os = new FileOutputStream(path+"/"+ produto.getImagemURL());		
					    
					    IOUtils.copy(filecontent, os);
	
					    filecontent.close();
						os.close();		
				    }else{
				    	produtoDAO.atualizarSemImagem(produto);
				    }
					
				} catch (Exception e) {					
					e.printStackTrace();
					paginaErro(request, response, "Erro ao atualizar produto", e.getMessage());	
				}
				
			}else if (request.getParameter("novo") != null){
				try {
					
					filePart = request.getPart("imagem"); 
				    String filename = getFilename(filePart);
				    produto.setExtencao(FilenameUtils.getExtension(filename));
					
					produtoDao.gravar(produto, false);	
					
				    
				    InputStream filecontent = filePart.getInputStream();	    					
				    OutputStream os = new FileOutputStream(path +"/"+ produto.getImagemURL());		
				    
				    IOUtils.copy(filecontent, os);

				    filecontent.close();
					os.close();		
					
					
				} catch (Exception e) {					
					e.printStackTrace();
					paginaErro(request, response, "Erro ao cadastrar produto", e.getMessage());	
				}}
			else if (request.getParameter("deletar") != null){
				try {
					produtoDao.deletar(produto.getId());
				} catch (Exception e) {					
					e.printStackTrace();
					paginaErro(request, response, "Erro ao deletar produto", e.getMessage());	
				}}
			
			//atualiza imagem
			if(request.getParameter("atualizar") != null || request.getParameter("novo") != null){	
				
			}else if(request.getParameter("deletar") != null){
				Files.deleteIfExists(Paths.get(produto.getImagemURL()));
			}

			response.sendRedirect(request.getHeader("Referer"));
			
			break;			
			
		case "index":
			
			 produtoDAO = null;
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
				e.printStackTrace();
				paginaErro(request, response, "Erro ao listar produtos", e.getMessage());	
			}
			
			request.setAttribute("listaDestaque", listaDestaque);
			
			forward(request, response, "/index.jsp");			
			
			break;
			
		case "detalhesProduto":
			
			 try {
				produtoDAO = new ProdutoDAO();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			 int id = Integer.valueOf(request.getParameter("id"));
			 
			 ProdutoBean p = null;
			try {
				p = produtoDAO.carregar(id);
			} catch (Exception e) {				
				e.printStackTrace();
				paginaErro(request, response, "Erro ao carregar dados do produto", e.getMessage());	
			}
			 
			request.setAttribute("produto", p);
			
			forward(request, response, "/detalhesProduto.jsp");	
			break;
			
		case "conta":
			
			forward(request, response, "/conta.jsp");	
			break;
			
		case "enviarEmail":
			
			forward(request, response, "/conta.jsp");	
			break;
			
		case "carrinho":
			
			
			forward(request, response, "/carrinho.jsp");	
			break;
			
		case "quemsomos":
			
			forward(request, response, "/quemsomos.jsp");	
			break;
			
		case "contato":
			
			forward(request, response, "/contato.jsp");	
			break;
			
		case "admin":
			if(sub!=null)		
			switch (sub) {
			
			case "produto":
				try {
					produtoDAO = new ProdutoDAO();
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				ProdutoBean produtoAlterar = null;
				
				try {
					produtoAlterar = produtoDAO.carregar(Integer.valueOf(request.getParameter("id")));				
				} catch (Exception e) {					
					e.printStackTrace();
					paginaErro(request, response, "Erro ao carregar dados do produto", e.getMessage());	
				}
				
				request.setAttribute("produto",produtoAlterar);
				
				//seta qual aba do accordeon fica aberta
				request.setAttribute("active",0);	
				
				break;
				
			case "usuario":
				try {
					usuarioDAO = new UsuarioDAO();
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				UsuarioBean usuarioAlterar = null;
				
				try {
					usuarioAlterar = usuarioDAO.carregar(Integer.valueOf(request.getParameter("id")));				
				} catch (Exception e) {					
					e.printStackTrace();
					paginaErro(request, response, "Erro ao carregar dados do usuário", e.getMessage());	
				}
				
				request.setAttribute("usuario",usuarioAlterar);
				request.setAttribute("active",1);	
				break;		
				
				case "categoria":
					request.setAttribute("active",2);	
				break;
			}
			
		
			
			forward(request, response, "/admin.jsp");	
			
			break;
			
		case "usuarios":
			
			try {
				usuarioDAO = new UsuarioDAO();
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			List<UsuarioBean> listaUsuarios = null;
			
			List<String> campos = new ArrayList<>();
			campos.add("nome");
			campos.add("email");
			campos.add("cpf");
			campos.add("cnpj");
			
			
			try {	
				String pesquisa = request.getParameter("pesquisa");
				
				if(pesquisa != null && pesquisa.length() > 0)				
				listaUsuarios = usuarioDAO.pesquisar(pesquisa, campos);	
				else
				listaUsuarios = usuarioDAO.carregarTodos();		
				
			} catch (Exception e) {				
				e.printStackTrace();
				paginaErro(request, response, "Erro ao carregar lista de usuários", e.getMessage());	
			}
			
			request.setAttribute("listaUsuarios",listaUsuarios);
			
			forward(request, response, "/usuarios.jsp");			
			break;
			
		case "novaconta":
			
			forward(request, response, "/novaconta.jsp");			
			break;
			
	
		default:
			paginaErro(request, response, "Ação Inexistente", null);	
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
			e.printStackTrace();
			paginaErro(request, response, "Erro ao carregar lista de categorias", e.getMessage());	
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
	
	
	private void paginaErro(HttpServletRequest request, HttpServletResponse response,String mensagem, String stacktrace){
		request.setAttribute("mensagem", mensagem);
		request.setAttribute("stacktrace", stacktrace);
		request.setAttribute("voltar", request.getHeader("Referer"));	
		forward(request, response, "/erro.jsp");		
	}
	
}
