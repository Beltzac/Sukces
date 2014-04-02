<div id="menu_tab">
    <ul class="menu">
        <li>
            <a href="index.jsp" class="nav">Home</a>
        </li>

        <%      
        if (usuario.isAutenticado()) {
        	%>
        	
            <li class="divider"></li>
            <li>
                <a href="conta.jsp" class="nav">Minha Conta</a>
            </li>
            <li class="divider"></li>
            <li>
                <a href="carrinho.jsp" class="nav">Meu Carrinho</a>
            </li>

          <%  } %>

        <li class="divider"></li>
        <li>
            <a href="quemsomos.jsp" class="nav">Quem Somos</a>
        </li>
        <li class="divider"></li>
        <li>
            <a href="contato.jsp" class="nav">Contato</a>
        </li>

        <% 
        if (usuario.isAdministrador()) {
        	%>
            <li class="divider"></li>
            <li>
                <a href="admin.jsp" class="nav">Administração do site</a>
            </li>

      <%    
      }
        if (usuario.isAutenticado()) {
        	%>
            <li class="divider"></li>
            <li>
                <a href="login_manager.jsp?logout=true" class="nav" style = " font-size: 15 ; color: tomato; ">Logout ( <% System.out.print("Mudar nome"); %>)</a>
            </li>

            <%
        } else {
            %>

            <li class="divider"></li>
            <li>
                <a href="novaconta.jsp" class="nav" style = " font-size: 15 ; color: tomato; ">Criar uma conta</a>
            </li>

        <%} %>

    </ul>

</div>
