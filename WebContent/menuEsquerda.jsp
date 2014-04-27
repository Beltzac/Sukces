<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="left_content">
    <div class="title_box">
        Categorias
    </div>

    <ul class="left_menu">

        <c:forEach items="${listaCategorias}" var="item"  varStatus="cont">
        	<c:choose>
        		<c:when test="${cont.index % 2 == 1}">
        		<li class="odd">
        		</c:when>
        		
        		<c:otherwise>
        		<li class="even">        		
        		</c:otherwise>
        	</c:choose>
        	
        	<a href="Controladora?action=pesquisaProduto&pesquisa=${item.id}">${item.nome}</a>        	
        	
        	</li>
        </c:forEach>
    </ul>

    <div class="title_box">
        Promoção!
    </div>
    <div class="border_box">
        <div class="product_title">
            <a href="details.jsp?cod=<?php echo $codigo; ?>"><?php echo $nome; ?></a>
        </div>
        <div class="product_img">
            <a href="details.jsp?cod=<?php echo $codigo; ?>"><img src="<?php echo $imagem; ?>" alt="" title="" border="0" height = "100"/></a>
        </div>
        <div class="prod_price">
            <span class="price">R$ <?php echo $preco; ?></span>
        </div>
    </div>
    
    <div class="banner_adds">

        <a href="#"><img src="images/bann2.jpg" alt="" title="" border="0" /></a>
    </div>

</div><!-- menu esquerda -->
