<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Resultados da pesquisa</title>
        <link rel="stylesheet" type="text/css" href="style.css" />        
    </head>
    <body>
<div id="main_container">

             <%@ include file="header.jsp"%>    
                
             <% 	
             if (!loginBean.isAutenticado() || !loginBean.getUsuario().isAdministrador())
 				response.sendRedirect("index.jsp");
			%>

            <div id="main_content">
               
        
 <%@ include file="menu.jsp"%>       
 <%@ include file="menuEsquerda.jsp"%>    

                <div class="center_content">
                    <form action="pesquisaPessoa.php" method="get">
                        <input type="text" name="pesquisa" class="newsletter_input" value=""/>
                        <input class="submit" type="submit" value="Pesquisar Pessoa" name="tipo"/>
                    </form>
                    <div class="center_title_bar">
                        Resultados da pesquisa
                    </div>

                    <?php
                    require_once 'DAO/PessoaDAO.php';

                    $pdao = new PessoaDAO();

                    if (isset($_GET['pesquisa'])) {
                        $pesquisa = $pdao->selectLike($_GET['pesquisa']);

                        foreach ($pesquisa as $pessoa) {

                            caixaPessoa($pessoa);
                        }
                    }
                    ?>

                 </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
