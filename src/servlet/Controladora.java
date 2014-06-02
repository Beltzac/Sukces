package servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.Carrinho;
import model.ItemCarrinho;
import model.Pagamento;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;

import util.FormUtil;
import bean.CategoriaBean;
import bean.ItemPedidoBean;
import bean.LoginBean;
import bean.ProdutoBean;
import bean.UsuarioBean;
import bean.PedidoBean;
import dao.CategoriaDAO;
import dao.PedidoDAO;
import dao.ProdutoDAO;
import dao.UsuarioDAO;

/**
 * Servlet implementation class Controladora
 */
@WebServlet("/Controladora")
@MultipartConfig
public class Controladora extends Servlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controladora() {
		super();
	}

	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		String sub = request.getParameter("sub");

		HttpSession session = request.getSession();

		LoginBean loginBean;

		UsuarioDAO usuarioDAO = null;
		ProdutoDAO produtoDAO = null;
		PedidoDAO pedidoDAO = null;

		String path = getServletContext().getRealPath("/");

		// carrega categorias, etc
		carregarObjetosComuns(request, response);

		if (action == null) {
			response.sendRedirect("Controladora?action=index");
		} else
			switch (action) {
			case "login":

				loginBean = FormUtil.populate(LoginBean.class, request);

				if (loginBean.autenticar()) {
					System.out.println("Usuario logando:"
							+ loginBean.getEmail());
					session.setAttribute("loginBean", loginBean);
					response.sendRedirect(request.getHeader("Referer"));
				} else {
					paginaErro(request, response,
							"Login e/ou senha incorretos", null);
					return;
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
				response.sendRedirect("Controladora?action=index");

				break;

			case "categoria":
				if (!filtroAdmin(request, response)) {
					return;
				}
				CategoriaDAO categoriaDao = null;
				try {
					categoriaDao = new CategoriaDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Categoria)", e.getMessage());
					return;
				}

				CategoriaBean categoria = FormUtil.populate(
						CategoriaBean.class, request);

				if (request.getParameter("atualizar") != null)
					try {
						categoriaDao.gravar(categoria, true);
					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao atualizar a categoria", e.getMessage());
						return;
					}
				else if (request.getParameter("novo") != null)
					try {
						categoriaDao.gravar(categoria, false);
					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao cadastrar a categoria", e.getMessage());
						return;
					}
				else if (request.getParameter("deletar") != null)
					try {
						categoriaDao.deletar(categoria.getId());
					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao deletar a categoria", e.getMessage());
						return;
					}

				response.sendRedirect("Controladora?action=admin&sub=categoria");

				break;
			case "novoUsuario":

				usuarioDAO = null;
				try {
					usuarioDAO = new UsuarioDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Usuário)", e.getMessage());
					return;
				}

				UsuarioBean usuario = FormUtil.populate(UsuarioBean.class,
						request);

				try {
					usuarioDAO.gravar(usuario, false);
				} catch (Exception e1) {
					e1.printStackTrace();
					paginaErro(request, response,
							"Erro ao cadastrar sua conta", e1.getMessage());
					return;
				}

				response.sendRedirect("Controladora?action=index");

				break;
			case "atualizarUsuario":
				if (!filtroLogado(request, response)) {
					return;
				}

				usuarioDAO = null;
				try {
					usuarioDAO = new UsuarioDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Usuário)", e.getMessage());
					return;
				}

				UsuarioBean usuarioNovo = FormUtil.populate(UsuarioBean.class,
						request);

				loginBean = (LoginBean) session.getAttribute("loginBean");

				// Para não mandar o booleano de administrador pelo form
				usuarioNovo.setAdministrador(loginBean.getUsuario()
						.isAdministrador());

				try {
					usuarioDAO.gravar(usuarioNovo, true);
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao atualizar sua conta", e.getMessage());
					return;
				}
				loginBean.setUsuario(usuarioNovo);
				response.sendRedirect(request.getHeader("Referer"));

				break;
				
			case "atualizarSenha":
				if (!filtroLogado(request, response)) {
					return;
				}
				
				String senhaNova1 = request.getParameter("senhaNova1");
				String senhaNova2 = request.getParameter("senhaNova2");
				String senhaAntiga = request.getParameter("senhaAntiga");	

				usuarioDAO = null;
				try {
					usuarioDAO = new UsuarioDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Usuário)", e.getMessage());
					return;
				}				

				
				if(!senhaNova1.equals(senhaNova2)){
					paginaErro(request, response,"Erro ao alterar sua senha", "Senha 1 e Senha 2 devem ser iguais.");
					return;
				}
				
				if(senhaNova1 == null || senhaNova1.length() < 6){
					paginaErro(request, response,"Erro ao alterar sua senha", "Nova senha deve conter no minimo 6 caracteres.");
					return;
				}
				
				loginBean = (LoginBean) session.getAttribute("loginBean");
				
				
				try {
					
					int registrosAlterados = 0;
					registrosAlterados = usuarioDAO.alterarSenha(loginBean.getUsuario(), senhaNova1, senhaAntiga);
					if (registrosAlterados != 1){
						paginaErro(request, response, "Erro ao alterar sua senha", "Senha antiga incorreta");
						return;
					}
					
				} catch (Exception e4) {
					e4.printStackTrace();
					paginaErro(request, response, "Erro ao processar (Usuário)", e4.getMessage());
					return;
				}
				
				
				response.sendRedirect(request.getHeader("Referer"));

				break;

			case "atualizarUsuarioAdmin":
				if (!filtroAdmin(request, response)) {
					return;
				}
				usuarioDAO = null;
				try {
					usuarioDAO = new UsuarioDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Usuário)", e.getMessage());
					return;
				}

				UsuarioBean usuarioAdmin = FormUtil.populate(UsuarioBean.class,
						request);

				try {
					usuarioDAO.gravar(usuarioAdmin, true);
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao atualizar a conta do usuario",
							e.getMessage());
					return;
				}

				response.sendRedirect(request.getHeader("Referer"));

				break;

			case "produto":
				if (!filtroAdmin(request, response)) {
					return;
				}
				ProdutoDAO produtoDao = null;
				try {
					produtoDao = new ProdutoDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Produto)", e.getMessage());
					return;
				}

				ProdutoBean produto = FormUtil.populate(ProdutoBean.class,
						request);
				Part filePart = null;

				if (request.getParameter("atualizar") != null) {

					try {
						filePart = request.getPart("imagem");

						if (filePart != null && filePart.getSize() != 0) {
							String filename = getFilename(filePart);
							produto.setExtencao(FilenameUtils
									.getExtension(filename));

							produtoDao.gravar(produto, true);

							InputStream filecontent = filePart.getInputStream();
							OutputStream os = new FileOutputStream(path + "/"
									+ produto.getImagemURL());

							IOUtils.copy(filecontent, os);

							filecontent.close();
							os.close();
						} else {
							produtoDao.atualizarSemImagem(produto);
						}

					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao atualizar produto", e.getMessage());
						return;
					}

				} else if (request.getParameter("novo") != null) {
					try {

						filePart = request.getPart("imagem");
						String filename = getFilename(filePart);
						produto.setExtencao(FilenameUtils
								.getExtension(filename));

						produtoDao.gravar(produto, false);

						InputStream filecontent = filePart.getInputStream();
						OutputStream os = new FileOutputStream(path + "/"
								+ produto.getImagemURL());

						IOUtils.copy(filecontent, os);

						filecontent.close();
						os.close();

					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao cadastrar produto", e.getMessage());
						return;
					}
				} else if (request.getParameter("deletar") != null) {
					try {
						produtoDao.deletar(produto.getId());
					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao deletar produto", e.getMessage());
						return;
					}
				}

				// atualiza imagem
				if (request.getParameter("atualizar") != null
						|| request.getParameter("novo") != null) {

				} else if (request.getParameter("deletar") != null) {
					Files.deleteIfExists(Paths.get(produto.getImagemURL()));
				}

				response.sendRedirect(request.getHeader("Referer"));

				break;

			case "index":

				produtoDAO = null;
				try {
					produtoDAO = new ProdutoDAO();
				} catch (Exception e1) {
					e1.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Produto)", e1.getMessage());
					return;
				}

				List<ProdutoBean> listaDestaque = null;
				try {
					listaDestaque = produtoDAO.carregarTodos();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response, "Erro ao listar produtos",
							e.getMessage());
					return;
				}

				request.setAttribute("listaDestaque", listaDestaque);

				forward(request, response, "/index.jsp");

				break;

			case "pesquisaProduto":

				produtoDAO = null;
				try {
					produtoDAO = new ProdutoDAO();
				} catch (Exception e1) {
					e1.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Produto)", e1.getMessage());
					return;
				}

				List<ProdutoBean> listaProdutos = null;
				List<String> campos = new ArrayList<>();
				campos.add("nome");
				campos.add("categoria");
				campos.add("descricao");

				try {

					String pesquisa2 = request.getParameter("pesquisa");

					if (pesquisa2 != null && pesquisa2.length() > 0)
						listaProdutos = produtoDAO.pesquisar(pesquisa2, campos);
					else
						listaProdutos = produtoDAO.carregarTodos();

				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response, "Erro ao pesquisar produtos",
							e.getMessage());
					return;
				}

				request.setAttribute("listaProdutos", listaProdutos);

				forward(request, response, "/pesquisaProduto.jsp");

				break;

			case "detalhesProduto":

				try {
					produtoDAO = new ProdutoDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Produto)", e.getMessage());
					return;
				}

				int id = Integer.valueOf(request.getParameter("id"));

				ProdutoBean p = null;
				try {
					p = produtoDAO.carregar(id);
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao carregar dados do produto", e.getMessage());
					return;
				}

				request.setAttribute("produto", p);

				forward(request, response, "/detalhesProduto.jsp");
				break;

				
			case "detalhesPedido":

				try {
					pedidoDAO = new PedidoDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Pedido)", e.getMessage());
					return;
				}

				int idPedido = Integer.valueOf(request.getParameter("id"));

				PedidoBean ped = null;
				try {
					ped = pedidoDAO.carregar(idPedido);
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao carregar dados do pedido", e.getMessage());
					return;
				}
				
				
				
				try {
					usuarioDAO = new UsuarioDAO();
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Usuario)", e.getMessage());
					return;
				}			

				UsuarioBean cli = null;
				try {
					cli = usuarioDAO.carregar(ped.getUsuario());
				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao carregar dados do usuario", e.getMessage());
					return;
				}	
				
				request.setAttribute("pedido", ped);
				request.setAttribute("usuario", cli);

				forward(request, response, "/detalhesPedido.jsp");
				break;
				
			case "conta":
				if (!filtroLogado(request, response)) {
					return;
				}
				loginBean = (LoginBean) session.getAttribute("loginBean");
				
				pedidoDAO = null;
				try {
					pedidoDAO = new PedidoDAO();
				} catch (Exception e4) {
					e4.printStackTrace();
					paginaErro(request, response,
							"Erro ao carregar pedidos", e4.getMessage());
					return;
				}
				
				try {
					request.setAttribute("listaPedidos", pedidoDAO.carregarTodos(loginBean.getUsuario().getId()));
					
				} catch (Exception e4) {
					e4.printStackTrace();
					paginaErro(request, response,
							"Erro ao carregar pedidos", e4.getMessage());
					return;
				}
				
				forward(request, response, "/conta.jsp");
				break;

			case "enviarEmail":

				forward(request, response, "/conta.jsp");
				break;

			case "carrinho":
				if (!filtroLogado(request, response)) {
					return;
				}

				Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
				if (carrinho == null) {
					carrinho = new Carrinho();
					session.setAttribute("carrinho", carrinho);
				}

				if (request.getParameter("id") != null) {
					int idProduto = Integer.valueOf(request.getParameter("id"));
					try {
						produtoDAO = new ProdutoDAO();
					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao processar (Produto)", e.getMessage());
						return;
					}
					int quantidade;
					ProdutoBean produtoEscolhido;

					switch (sub) {
					case "adicionar":
						

						if (request.getParameter("quantidade") == null) {
							quantidade = 1;
						} else {
							quantidade = Integer.valueOf(request
									.getParameter("quantidade"));
						}

						try {
							produtoDAO = new ProdutoDAO();
						} catch (Exception e3) {
							e3.printStackTrace();
							paginaErro(request, response,
									"Erro ao processar (Produto)",
									e3.getMessage());
							return;
						}

						produtoEscolhido = null;
						try {
							produtoEscolhido = produtoDAO.carregar(idProduto);
						} catch (Exception e2) {							
							e2.printStackTrace();
							paginaErro(request, response,
									"Erro ao carregar dados do produto",
									e2.getMessage());
							return;
						}
						carrinho.adicionaProduto(produtoEscolhido, quantidade);
						break;

					case "remover":
						carrinho.removeProduto(idProduto);
						break;

					case "alterar":						
						if (request.getParameter("quantidade") == null) {
							quantidade = 1;
						} else {
							quantidade = Integer.valueOf(request
									.getParameter("quantidade"));
						}

						try {
							produtoDAO = new ProdutoDAO();
						} catch (Exception e3) {
							e3.printStackTrace();
							paginaErro(request, response,
									"Erro ao processar (Produto)",
									e3.getMessage());
							return;
						}

						produtoEscolhido = null;
						try {
							produtoEscolhido = produtoDAO.carregar(idProduto);
						} catch (Exception e2) {							
							e2.printStackTrace();
							paginaErro(request, response,
									"Erro ao carregar dados do produto",
									e2.getMessage());
							return;
						}
						carrinho.removeProduto(idProduto);
						carrinho.adicionaProduto(produtoEscolhido, quantidade);
						break;				
					}
				}else{
					if(sub !=null)
					switch (sub) {
					
						case "finalizar":							
						loginBean = (LoginBean) session.getAttribute("loginBean");
						Pagamento pagamento = new Pagamento();
						String url = pagamento.enviaPagSeguro(carrinho, loginBean.getUsuario());
						
						
						PedidoBean pedido = new PedidoBean();
						pedido.setUsuario(loginBean.getUsuario().getId());
						
						ArrayList<ItemPedidoBean> lista = new ArrayList<>();
						for (ItemCarrinho item : carrinho.getListaItens()) {
							ItemPedidoBean itemPedido = new ItemPedidoBean();
							
							itemPedido.setComentarios(item.getComentarios());
							itemPedido.setImagem(item.getImagem());
							itemPedido.setProduto(item.getProduto().getId());
							itemPedido.setQuantidade(item.getQuantidade());
							itemPedido.setValor(item.getPreco());		
							lista.add(itemPedido);
							
						}						
						pedido.setItems(lista);						
						
						
						pedido.setTransactionCode(loginBean.getUsuario().getId() + "-" + System.currentTimeMillis());
						
						pedidoDAO = null;
						try {
							pedidoDAO = new PedidoDAO();
						} catch (Exception e) {
							e.printStackTrace();
							paginaErro(request, response,
									"Erro ao gravar pedido",
									e.getMessage());
							return;
						}
						
						try {							
							pedidoDAO.gravar(pedido, false);
						} catch (Exception e) {
							e.printStackTrace();
							paginaErro(request, response,
									"Erro ao gravar pedido",
									e.getMessage());
							return;
						}
						
						session.setAttribute("carrinho", null);
						
						
						response.sendRedirect(url);	
						return;		
						
					}
				}
				
				
				forward(request, response, "/carrinho.jsp");
				break;

			case "quemsomos":

				forward(request, response, "/quemsomos.jsp");
				break;

			case "contato":

				forward(request, response, "/contato.jsp");
				break;
				
			case "atualizarPedido":				
				int idPedidoAtualizar = Integer.valueOf(request.getParameter("id"));
				
				pedidoDAO = null;
				try {
					pedidoDAO = new PedidoDAO();
				} catch (Exception e1) {
					e1.printStackTrace();
					paginaErro(request, response, "Erro ao processar (Pedido)",
							e1.getMessage());
					return;
				}
				
				
				switch (request.getParameter("opcao")) {
				case "imagemOK":
					
					break;
					
				case "pagamentoOK":
					
					break;
					
				case "confeccaoOK":
	
					break;	
					
				default:
					paginaErro(request, response, "Ação Inexistente", null);
					return;
				}			

				forward(request, response, "Controladora?action=detalhesPedido&id=" + idPedidoAtualizar);
				break;
				

			case "admin":
				 pedidoDAO = null;
				try {
					pedidoDAO = new PedidoDAO();
				} catch (Exception e1) {
					e1.printStackTrace();
					paginaErro(request, response, "Erro ao processar (Pedido)",
							e1.getMessage());
					return;
				}
				List<PedidoBean> listaPedidos = null;
				
				if(request.getParameter("option")==null){
					try {
						listaPedidos = pedidoDAO.carregarTodos();
					} catch (Exception e) {
						e.printStackTrace();
						paginaErro(request, response,
								"Erro ao carregar lista de pedidos", e.getMessage());
						return;
					}
	
					request.setAttribute("listaPedidos", listaPedidos);
				}
				
				if (!filtroAdmin(request, response)) {
					return;
				}
				if (sub != null)
					switch (sub) {

					case "produto":
						try {
							produtoDAO = new ProdutoDAO();
						} catch (Exception e1) {
							e1.printStackTrace();
							paginaErro(request, response,
									"Erro ao processar (Produto)",
									e1.getMessage());
							return;
						}

						ProdutoBean produtoAlterar = null;

						try {
							produtoAlterar = produtoDAO.carregar(Integer
									.valueOf(request.getParameter("id")));
						} catch (Exception e) {
							e.printStackTrace();
							paginaErro(request, response,
									"Erro ao carregar dados do produto",
									e.getMessage());
							return;
						}

						request.setAttribute("produto", produtoAlterar);

						// seta qual aba do accordeon fica aberta
						request.setAttribute("active", 0);

						break;

					case "usuario":
						try {
							usuarioDAO = new UsuarioDAO();
						} catch (Exception e1) {
							e1.printStackTrace();
							paginaErro(request, response,
									"Erro ao processar (Usuário)",
									e1.getMessage());
							return;
						}

						UsuarioBean usuarioAlterar = null;

						try {
							usuarioAlterar = usuarioDAO.carregar(Integer
									.valueOf(request.getParameter("id")));
						} catch (Exception e) {
							e.printStackTrace();
							paginaErro(request, response,
									"Erro ao carregar dados do usuário",
									e.getMessage());
							return;
						}

						request.setAttribute("usuario", usuarioAlterar);
						request.setAttribute("active", 1);
						break;

					case "categoria":
						request.setAttribute("active", 2);
						break;
						
					case "pedido":
						try {
							listaPedidos = pedidoDAO.carregarTodos(request.getParameter("option"));
						} catch (Exception e) {
							e.printStackTrace();
							paginaErro(request, response,
									"Erro ao carregar lista de pedidos", e.getMessage());
							return;
						}
		
						request.setAttribute("listaPedidos", listaPedidos);
						request.setAttribute("active", 3);
						break;
					}

				forward(request, response, "/admin.jsp");

				break;

			case "usuarios":
				if (!filtroAdmin(request, response)) {
					return;
				}
				try {
					usuarioDAO = new UsuarioDAO();
				} catch (Exception e1) {
					e1.printStackTrace();
					paginaErro(request, response,
							"Erro ao processar (Usuário)", e1.getMessage());
					return;
				}

				List<UsuarioBean> listaUsuarios = null;

				List<String> campos2 = new ArrayList<>();
				campos2.add("nome");
				campos2.add("email");
				campos2.add("cpf");
				campos2.add("cnpj");

				try {
					String pesquisa = request.getParameter("pesquisa");

					if (pesquisa != null && pesquisa.length() > 0)
						listaUsuarios = usuarioDAO.pesquisar(pesquisa, campos2);
					else
						listaUsuarios = usuarioDAO.carregarTodos();

				} catch (Exception e) {
					e.printStackTrace();
					paginaErro(request, response,
							"Erro ao carregar lista de usuários",
							e.getMessage());
					return;
				}

				request.setAttribute("listaUsuarios", listaUsuarios);

				forward(request, response, "/usuarios.jsp");
				break;

			case "novaconta":
				session = request.getSession();
				loginBean = (LoginBean) session.getAttribute("loginBean");
				if (loginBean != null && loginBean.isAutenticado()) {
					response.sendRedirect("Controladora?action=index");
					return;
				}
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
			e1.printStackTrace();
			paginaErro(request, response, "Erro ao processar (Categoria)",
					e1.getMessage());
			return;
		}
		List<CategoriaBean> listaCategorias = null;
		try {
			listaCategorias = categoriaDAO.carregarTodos();
		} catch (Exception e) {
			e.printStackTrace();
			paginaErro(request, response,
					"Erro ao carregar lista de categorias", e.getMessage());
			return;
		}

		request.setAttribute("listaCategorias", listaCategorias);

	}


	private static String getFilename(Part part) {
		for (String cd : part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				String filename = cd.substring(cd.indexOf('=') + 1).trim()
						.replace("\"", "");
				return filename.substring(filename.lastIndexOf('/') + 1)
						.substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
			}
		}
		return null;
	}
		
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}


	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}
