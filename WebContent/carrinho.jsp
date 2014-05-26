<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${!loginBean.autenticado}">
	<c:redirect url="Controladora?action=index" />
</c:if>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Carrinho</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script src="js/jquery-2.0.2.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jquery-ui.min.css" />
</head>
<body>

	<div id="main_container">

		<%@ include file="header.jsp"%>

		<div id="main_content">


			<%@ include file="menu.jsp"%>
			<%@ include file="menuEsquerda.jsp"%>

			<div class="center_content">

				<div class="center_title_bar">Meu carrinho</div>
				
				<c:if test="${carrinho.quantidadeItensUnicos==0}">
					<h2>Você não escolheu nenhum produto ainda</h2>
				</c:if>

				
				<c:forEach items="${carrinho.listaItens}" var="item">

					<script>
						$(function() {
							$('#spinner${item.produto.id}').spinner({
								step : 1,
								numberFormat : "n",
								min : 1,
								max : 200
							});
						});
					</script>

					<div class="carrinho_box">

						<div class="carrinho_center_prod_box2">
							<div class="product_img2">
								<a
									href="Controladora?action=detalhesProduto&id=${item.produto.id}"><img
									src="${item.produto.imagemURL}" alt="" title="" border="0"
									class="img" /></a>
							</div>
							<div class="product_title2">
								<a
									href="Controladora?action=detalhesProduto&id=${item.produto.id}">${item.produto.nome}</a>
							</div>

							<div class="prod_price2">
								<span class="price"><fmt:formatNumber
										value="${item.preco}" type="currency" /></span>
							</div>
							<form action="Controladora?action=carrinho&sub=alterar&id=${item.produto.id}" method="post">

								<div class="prod_price2">
									<p>
										<label for="spinner${item.produto.id}">Quantidade:</label> <input
											id="spinner${item.produto.id}" name="quantidade"
											value="${item.quantidade}" />
									</p>
								</div>
								
								<div class="prod_price2">
								Comentarios:
									<p>									
									<textarea rows="5" cols="30" name="comentarios">${item.comentarios}</textarea>										
									</p>
								</div>
								
								<div class="prod_price2">
								Imagem:
									<p>									
									<input type="file" class="contact_input" name="imagem" />															
									</p>
								</div>

								<div class="carrinho_prod_details_tab2">
									<a
										href="Controladora?action=detalhesProduto&id=${item.produto.id}"
										class="prod_details">Detalhes</a> <a
										href="Controladora?action=carrinho&sub=remover&id=${item.produto.id}"
										class="prod_buy">Remover</a> 
										<input type="submit" value="Atualizar" class="prod_buy"/>
								</div>
							</form>
						</div>
						<br />
					</div>
					<br />

				</c:forEach>

				<c:if test="${carrinho.quantidadeItensUnicos>0}">
					<div class="form_row">
						<a href="Controladora?action=carrinho&sub=finalizar" class="prod_buy">Finalizar</a>
					</div>
				</c:if>

				
			</div>
			<!-- center -->


			<%@ include file="menuDireita.jsp"%>

		</div>
		<!-- main index -->

		<%@ include file="footer.html"%>
	</div>
</body>
</html>
