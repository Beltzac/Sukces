<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Resultados da pesquisa</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

	<div id="main_container">

		<%@ include file="header.jsp"%>

		<div id="main_content">

			<%@ include file="menu.jsp"%>
			<%@ include file="menuEsquerda.jsp"%>

			<div class="center_content">
				<div class="center_title_bar">Resultados da pesquisa</div>

				<c:forEach items="${listaProdutos}" var="produto">
					<div class="prod_box">

						<div class="center_prod_box">
							<div class="product_title">
								<a href="Controladora?action=detalhesProduto&id=${produto.id}">${produto.nome}</a>
							</div>
							<div class="product_img">
								<a href="Controladora?action=detalhesProduto&id=${produto.id}"><img
									src="${produto.imagemURL}" alt="" title="" border="0"
									class="img" /></a>
							</div>
							<div class="prod_price">
								<span class="price">R$ <fmt:formatNumber value="${produto.preco}" minFractionDigits="2"/></span>
							</div>
						</div>

						<div class="prod_details_tab">
							<a href="" class="prod_buy">+ Carrinho</a> <a
								href="Controladora?action=detalhesProduto&id=${produto.id}"
								class="prod_details">Detalhes</a>

							<c:if
								test="${loginBean.autenticado && loginBean.usuario.administrador}">
								<a
									href="Controladora?action=admin&sub=produto&id=${produto.id}"
									class="prod_buy" style="color: red">Modificar</a>
							</c:if>
						</div>
					</div>

				</c:forEach>

			</div>
			<!-- center -->
			
			<%@ include file="menuDireita.jsp"%>

		</div>
		<!-- main index -->
		
		<%@ include file="footer.html"%>
	</div>
</body>
</html>
