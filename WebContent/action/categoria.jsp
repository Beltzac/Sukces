<%@page import="dao.CategoriaDAO"%>


<jsp:useBean id="categoria" class="bean.CategoriaBean" />
<jsp:setProperty property="*" name="categoria" />

<%
	CategoriaDAO dao = new CategoriaDAO();
	
	if (request.getParameter("atualizar") != null)
		dao.gravar(categoria, true);

	else if (request.getParameter("novo") != null)
		dao.gravar(categoria, false);

	else if (request.getParameter("deletar") != null)
		dao.deletar(categoria.getId());

	response.sendRedirect(request.getHeader("Referer"));
%>