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

</div><!-- menu esquerda -->
