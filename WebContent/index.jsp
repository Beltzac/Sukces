<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Sukces</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript" src="js/boxOver.js"></script>
</head>
<body>

	<div id="main_container">


		<%@ include file="header.jsp"%>


		<div id="main_content">


			<%@ include file="menu.jsp"%>
			<%@ include file="menuEsquerda.jsp"%>


			<div class="center_content">

				<div class="oferta">
					<img src="images/SmartphoneSamsungGalaxySIILiteDesbloqueadoTIM.jpg"
						height="113" border="0" class="oferta_img" alt="" title="" />

					<div class="oferta_details">
						<div class="oferta_title">Canecas Térmicas</div>
						<div class="oferta_text">É uma caneca preta que mostra a
							foto apos a insercao de algum liquido quente.</div>
						<a href="details.jsp" class="prod_buy">Detalhes</a>
					</div>
				</div>

				<div class="center_title_bar">Produtos em Destaque</div>



				<c:forEach items="${listaDestaque}" var="destaque">
					<div class="prod_box">

						<div class="center_prod_box">
							<div class="product_title">						
								<a href="Controladora?action=detalhesProduto&id=${destaque.id}">${destaque.nome}</a>
							</div>
							<div class="product_img">
								<a href="Controladora?action=detalhesProduto&id=${destaque.id}"><img
									src="${destaque.imagemURL}" alt="" title="" border="0"
									class="img" /></a>
							</div>
							<div class="prod_price">
								<span class="price">R$ ${destaque.preco}</span>
							</div>
						</div>

						<div class="prod_details_tab">
							<a
								href="Controladora?action=detalhesProduto&id=${destaque.id}"
								class="prod_buy">+ Carrinho</a> <a
								href="details.php?cod=<?php echo $codigo ?>"
								class="prod_details">Detalhes</a>

							<c:if
								test="${loginBean.autenticado && loginBean.usuario.administrador}">
								<a href="Controladora?action=admin&sub=produto&id=${destaque.id}"
									class="prod_buy" style="color: red">Modificar</a>
							</c:if>
						</div>
					</div>

				</c:forEach>

			</div>
			<!-- centro -->



			<%@ include file="menuDireita.jsp"%>

		</div>
		<!-- main index -->

		<%@ include file="footer.html"%>

	</div>
</body>
</html>