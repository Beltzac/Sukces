<%@page import="dao.UsuarioDAO"%>

<jsp:useBean id="usuario" class="bean.UsuarioBean" />
<jsp:setProperty property="*" name="usuario" />

<jsp:useBean id="loginBean" scope="session" class="bean.LoginBean" />

<%
	UsuarioDAO dao = new UsuarioDAO();

	// Para não mandar o booleano de administrador pelo form
	usuario.setAdministrador(loginBean.getUsuario().isAdministrador());
	
	dao.gravar(usuario,true);	
	loginBean.setUsuario(usuario);
	response.sendRedirect(request.getHeader("Referer"));
%>