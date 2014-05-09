<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="right_content">

	<div class="title_box">Pesquisa</div>
	<div class="border_box">
		<form action="Controladora?action=pesquisaProduto" method="post">
			<input type="text" name="pesquisa" class="newsletter_input" value="" />
			<input class="submit" type="submit" value="Pesquisar" name="tipo" />
		</form>
	</div>


	<c:choose>
		<c:when test="${loginBean.autenticado}">
		
			<div class="shopping_cart">
				<div class="title_box">Carrinho</div>

				<div class="cart_details">
					${carrinho.quantidadeItensUnicos}
					item(s) <br /> <span class="border_cart"></span> Total: <span
						class="price"><fmt:formatNumber value="${carrinho.total}" type="currency"/> </span>
				</div>

				<div class="cart_icon">
					<a href="Controladora?action=carrinho" title=""><img
						src="images/shoppingcart.png" alt="" title="" width="35"
						height="35" border="0" /></a>
				</div>

			</div>

		</c:when>

		<c:otherwise>

			<div class="login">
				<div class="title_box">Login</div>

				<form id="login" method="post" action="Controladora?action=login">
					E-mail: <input type="text" name="email" class="login_input"
						value="" /> Senha: <input type="password" name="senha"
						class="login_input" value="" /> <input class="join" type="submit"
						value="Login" />
				</form>
			</div>

		</c:otherwise>
	</c:choose>
</div>
<!-- menu direita -->
