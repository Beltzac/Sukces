<%@page import="dao.UsuarioDAO"%>

<jsp:useBean id="usuario" scope="session" class="bean.UsuarioBean" />
<jsp:setProperty property="*" name="usuario" />

<%
	UsuarioDAO dao = new UsuarioDAO();
	System.out.println(request.getHeader("Referer"));	
	dao.gravar(usuario);	
	response.sendRedirect(request.getHeader("Referer"));
%>