<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${loginBean.autenticado}">
		<jsp:useBean id="carrinho" class="model.Carrinho" scope="session" />
	</c:when>
</c:choose>
<fmt:setLocale value="pt_BR" />
<div id="header">

	<div class="top_right">

		<div class="big_banner">
			<a href="Controladora?action=index"><img
				src="images/banner728.jpg" alt="" title="" border="0" /></a>
		</div>

	</div>

	<div id="logo">
		<a href="Controladora?action=quemsomos"><img src="images/logo.png"
			alt="" title="" border="0" width="182" height="85" /></a>
	</div>

</div>

