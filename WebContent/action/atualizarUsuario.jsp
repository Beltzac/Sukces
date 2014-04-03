<%@page import="dao.PessoaDAO"%>

<jsp:useBean id="usuario" scope="session" class="bean.PessoaBean" />
<jsp:setProperty property="*" name="usuario" />

<%
 
	PessoaDAO dao = new PessoaDAO();
	System.out.println(request.getHeader("Referer"));	
	dao.gravar(usuario);	
	response.sendRedirect(request.getHeader("Referer"));
	
%>