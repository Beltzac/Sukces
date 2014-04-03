<jsp:useBean id="loginBean" scope="session" class="bean.LoginBean" />
<jsp:setProperty property="*" name="loginBean" />

<%
	if (request.getParameter("logout") != null) {
		if (session != null) {
			System.out.println("Usuario deslogado:"
					+ loginBean.getEmail());
			session.invalidate();
			response.sendRedirect("../index.jsp");
		}
	} else {		

		if (loginBean.autenticar()) {
			System.out.println("Usuario logando:" + loginBean.getEmail());
			response.sendRedirect(request.getHeader("Referer"));
		} else {
			loginBean.setEmail(null);
			loginBean.setSenha(null);
			response.sendRedirect("../index.jsp");
		}
	}
%>


