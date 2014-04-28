<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${produto == null}">
	<c:redirect url="Controladora?action=index"/>
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
        <script>           
            $(function() {
                $("#spinner").spinner({
                    step: 1,
                    numberFormat: "n",
                    min: 1,
                    max: 20
                });
            });
        </script>
    </head>
    <body>

       <div id="main_container">

             <%@ include file="header.jsp"%>       

            <div id="main_content">
               
        
 <%@ include file="menu.jsp"%>       
 <%@ include file="menuEsquerda.jsp"%>    
 

                <div class="center_content">

                    <div class="center_title_bar">
                        ${produto.nome}
                    </div>

                    <div class="prod_box_big">

                        <div class="center_prod_box_big">

                            <div class="product_img_big">
                         		  <img src="${produto.imagemURL}" alt="${produto.nome}" class="imgDetalhes">
                            </div>
                            <div class="details_big_box">
                                <div class="product_title_big">
                                   ${produto.nome}
                                </div>
                                <div class="specifications">                                   
                                    Descrição:<span class="blue"> ${produto.descricao}</span>
                                    <br />
                                </div>
                                <div class="prod_price_big">
                                    <span class="price">R$ <fmt:formatNumber value="${produto.preco}" minFractionDigits="2"/></span>
                                </div>

                                <form action="dao/carrinhoAction.php" method="get">
                                    <div class="prod_price2">
                                        <p>                         
                                            <input id="spinner" name="quantidade" value="1" />
                                        </p>
                                    </div>
                                    <input type="hidden" name="tipo" value="adicionarProduto">
                                        <input type="hidden" name="id" value="${produto.nome}">
                                            <input type="submit" id="but" style="display:none;">                                      
                                                <a href="#" onclick="document.getElementById('but').click();" class="prod_buy">Comprar</a>
                                                </form>
                                                
                                                <c:if test="${loginBean.autenticado && loginBean.usuario.administrador}">
                                               		 <a href = "Controladora?action=admin&sub=produto&id=${produto.id}" class="prod_buy" style="color:red">Modificar</a>													
												</c:if>


                                                </div>
                                                </div>

                                                </div>

                                                  </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
