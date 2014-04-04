<%@page import="dao.UsuarioDAO"%>

<jsp:useBean id="usuario" class="bean.UsuarioBean" />
<jsp:setProperty property="*" name="usuario" />

<%
 
	UsuarioDAO dao = new UsuarioDAO();	
	dao.gravar(usuario,false);	
	response.sendRedirect(request.getHeader("Referer"));
	
%>