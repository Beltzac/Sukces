<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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


	

				<div class="form_row">
					<a href="formapag.php" class="prod_buy">Finalizar</a>
				</div>
			</div>
			<!-- center -->


			<%@ include file="menuDireita.jsp"%>

		</div>
		<!-- main index -->
		
		<%@ include file="footer.html"%>
	</div>
</body>
</html>
