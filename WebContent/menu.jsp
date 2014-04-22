<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="menu_tab">
	<ul class="menu">
		<li><a href="index.jsp" class="nav">Home</a></li>

		<c:if test="${loginBean.autenticado}">

			<li class="divider"></li>
			<li><a href="conta.jsp" class="nav">Minha Conta</a></li>
			<li class="divider"></li>
			<li><a href="carrinho.jsp" class="nav">Meu Carrinho</a></li>
		</c:if>

		<li class="divider"></li>
		<li><a href="quemsomos.jsp" class="nav">Quem Somos</a></li>
		<li class="divider"></li>
		<li><a href="contato.jsp" class="nav">Contato</a></li>


		<c:if
			test="${loginBean.autenticado && loginBean.usuario.administrador}">
			<li class="divider"></li>
			<li><a href="admin.jsp" class="nav">Administração do site</a></li>
		</c:if>

		<c:choose>
			<c:when test="${loginBean.autenticado}">

				<li class="divider"></li>
				<li><a href="Controladora?action=logout" class="nav"
					style="font-size: 15; color: tomato;">Logout
						(${loginBean.usuario.nome})</a></li>
			</c:when>

			<c:otherwise>
				<li class="divider"></li>
				<li><a href="novaconta.jsp" class="nav"
					style="font-size: 15; color: tomato;">Criar uma conta</a></li>
			</c:otherwise>
		</c:choose>

	</ul>

</div>
