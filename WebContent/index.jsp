<!--<?php
include 'session_start.php';
?> -->



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
                        <img src="images/SmartphoneSamsungGalaxySIILiteDesbloqueadoTIM.jpg"  height="113" border="0" class="oferta_img" alt="" title="" />

                        <div class="oferta_details">
                            <div class="oferta_title">
                                Canecas Térmicas
                            </div>
                            <div class="oferta_text">
                                É uma caneca preta que mostra a foto apos a insercao de algum liquido quente.
                            </div>
                            <a href="details.jsp" class="prod_buy">Detalhes</a>
                        </div>
                    </div>

                    <div class="center_title_bar">
                        Produtos em Destaque
                    </div>

                    <?php
                    
                    //Procura produtos para preencher a pagina inicial, utiliza cache
                        require_once 'DAO/ProdutoDAO.php';
                        //include_once 'php_fast_cache.php';
                                                                      
                        //$data = phpFastCache::get("index");
        
        /*if(!$data){
            $pdao = new ProdutoDAO();   
            $data = $pdao->selectAll(9);
            phpFastCache::set("index",$data,300);
        }        */
		
		$pdao = new ProdutoDAO();   
            $data = $pdao->selectAll(9);
        foreach ($data as $value) 
        {               
           caixaProduto($value);
        }
                       ?>

                    <div class="center_title_bar">
                        Produtos Recomendados
                    </div>

                    <?php
                
                    

                    foreach ($data as $value) {

                        caixaProduto($value);
                        
                    }
                    ?>
                </div><!-- centro -->

               
                
<%@ include file="menuDireita.jsp"%>    
               
            </div><!-- main index -->

            <%@ include file="footer.html"%>   
             
        </div>
    </body>
</html>