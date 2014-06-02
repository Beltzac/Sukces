<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${pedido == null}">
	<c:redirect url="Controladora?action=admin" />
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Detalhes</title>
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

				<div class="center_title_bar">Pedido #${pedido.id}</div>

				<div class="prod_box_big">

					<div class="center_prod_box_big2">

						Comprador: ${usuario.nome}<br/>
						Total: <fmt:formatNumber value="${pedido.total}" type="currency"/><br/>
						Status: ${pedido.status}<br/>
						
						Itens:<br/>

						<table>
							<tr>
								<td>Produto</td>
								<td>Quantidade</td>
								<td>Valor</td>
								<td>Comentarios</td>
								<td>Imagem</td>
							</tr>

							<c:forEach items="${pedido.items}" var="item">
								<tr>
									<td>${item.produto}</td>
									<td>${item.quantidade}</td>
									<td><fmt:formatNumber value="${item.valor}" type="currency"/></td>
									<td>${item.comentarios}</td>
									<td>${item.imagem}</td>
								</tr>
							</c:forEach>

						</table>
						

						Relatório:
						<form method="post" action="relatorio">
							<input type='hidden' name='option' value='vendas'/>
							<input type='hidden' name='id' value="${pedido.id}"/>
						    <input type='submit' value='Gerar'/>
						</form>
						
						<c:if test="${loginBean.autenticado && loginBean.usuario.administrador}">
						<br />
						
						Administração:
						
						<table>
							<tr>
								<td>	
									<form method="post" action="relatorio">
										<input type='hidden' name='option' value='vendas'/>
										<input type='hidden' name='id' value="${pedido.id}"/>
						  				<input type='submit' value='Aprovar Imagens'/>
									</form>
							 	</td>													
							</tr>
							<tr>
								<td>	
									<form method="post" action="relatorio">
										<input type='hidden' name='option' value='vendas'/>
										<input type='hidden' name='id' value="${pedido.id}"/>
						  				<input type='submit' value='Verificar Pagamento'/>
									</form>
							 	</td>													
							</tr>
							<tr>
								<td>	
									<form method="post" action="relatorio">
										<input type='hidden' name='option' value='vendas'/>
										<input type='hidden' name='id' value="${pedido.id}"/>
						  				<input type='submit' value='Finalizar'/>
									</form>
							 	</td>													
							</tr>				
						</table>
					
						</c:if>

					</div>
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
