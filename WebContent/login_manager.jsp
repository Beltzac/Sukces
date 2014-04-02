<jsp:useBean id="usuario" scope="session" class="bean.PessoaBean" />
<jsp:setProperty property="*" name="usuario" />

<%
	if (request.getParameter("logout") != null) {
		if (session != null) {
			System.out.println("Usuario deslogado:"
					+ usuario.getEmail());
			session.invalidate();
			response.sendRedirect("index.jsp");
		}
	} else {
		//buscar usuario

		if (usuario.autenticar()) {
			System.out.println("Usuario logando:" + usuario.getEmail());
			response.sendRedirect("index.jsp");
		} else {
			usuario.setEmail(null);
			usuario.setSenha(null);
			response.sendRedirect("index.jsp");
		}
	}
%>


