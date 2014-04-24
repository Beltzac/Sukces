<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${!loginBean.autenticado}">
	<c:redirect url="Controladora?action=index"/>
</c:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Carrinho - Lolwtf Mobile</title>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <script type="text/javascript" src="js/boxOver.js"></script>
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

                    <div class="center_title_bar">
                        Meu carrinho
                    </div>

                    <?php
                    require_once 'DAO/carrinhoDAO.php';

                    //inicializa o carrinho se necessario            
                    if (!$_SESSION['carrinho'] || !isset($_SESSION['carrinho'])) {
                        header('Location: dao/carrinhoAction.php?tipo=iniciar');
                    }

                    $cardao = new carrinhoDAO();
                    $produtos = $cardao->selectProdutosPedido($_SESSION['carrinho']);

                    foreach ($produtos as $value) {
                        carrinhoProduto($value[0], $value[1]);
                    }

                    $t = $cardao->total($_SESSION['carrinho']);
                    echo 'Total:' . $t[0];
                    ?>

                    <div class="form_row">
                        <a href="formapag.php" class="prod_buy">Finalizar</a>
                    </div>
                   </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
