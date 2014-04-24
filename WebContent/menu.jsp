<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="menu_tab">
	<ul class="menu">
		<li><a href="Controladora?action=index" class="nav">Home</a></li>

		<c:if test="${loginBean.autenticado}">

			<li class="divider"></li>
			<li><a href="Controladora?action=conta" class="nav">Minha Conta</a></li>
			<li class="divider"></li>
			<li><a href="Controladora?action=carrinho" class="nav">Meu Carrinho</a></li>
		</c:if>

		<li class="divider"></li>
		<li><a href="Controladora?action=quemsomos" class="nav">Quem Somos</a></li>
		<li class="divider"></li>
		<li><a href="Controladora?action=contato" class="nav">Contato</a></li>


		<c:if
			test="${loginBean.autenticado && loginBean.usuario.administrador}">
			<li class="divider"></li>
			<li><a href="Controladora?action=admin" class="nav">Administração do site</a></li>
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
				<li><a href="Controladora?action=novaconta" class="nav"
					style="font-size: 15; color: tomato;">Criar uma conta</a></li>
			</c:otherwise>
		</c:choose>

	</ul>

</div>
