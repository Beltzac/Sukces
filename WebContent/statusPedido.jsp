<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Status do Pedido - Lolwtf Mobile</title>
        <link rel="stylesheet" type="text/css" href="style.css" />       
    </head>
    <body>

        <div id="main_container">

             <%@ include file="header.jsp"%>       

            <div id="main_content">
               
        
 <%@ include file="menu.jsp"%>       
 <%@ include file="menuEsquerda.jsp"%>    
                <div class="center_content">

                    <div class="center_title_bar">
                        Status do Pedido
                    </div><br/>

                    <table border='1'>
                        <?php
                        //teste
                        $form = $_POST['pagamento'];
                        if ($form == 'visa') {
                            echo "<tr><td>Pagamento</td><td>Visa</td></tr>";
                            echo "<tr><td>Status</td><td>Aguardando pagamento</td></tr>";
                        }
                        if ($form == 'master') {
                            echo "<tr><td>Pagamento</td><td>Mastercard</td></tr>";
                            echo "<tr><td>Status</td><td>Aguardando pagamento</td></tr>";
                        }
                        if ($form == 'hiper') {
                            echo "<tr><td>Pagamento</td><td>Hipercard</td></tr>";
                            echo "<tr><td>Status</td><td>Aguardando pagamento</td></tr>";
                        }
                        if ($form == 'diners') {
                            echo "<tr><td>Pagamento</td><td>Diners</td></tr>";
                            echo "<tr><td>Status</td><td>Aguardando pagamento</td></tr>";
                        }
                        if ($form == 'hsbc') {
                            echo "<tr><td>Pagamento</td><td>Boleto HSBC</td></tr>";
                            echo "<tr><td>Status</td><td>Aguardando pagamento</td></tr>";
                        }
                        if ($form == 'itau') {
                            echo "<tr><td>Pagamento</td><td>Boleto Itau</td></tr>";
                            echo "<tr><td>Status</td><td>Aguardando pagamento</td></tr>";
                        }

                        $env = $_POST['envio'];
                        if ($env == 'pac') {
                            echo "<tr><td>Forma de Envio</td><td>Correios via PAC</td></tr>";
                        } else if ($env == 'sedex') {
                            echo "<tr><td>Forma de Envio</td><td>Correios via Sedex</td></tr>";
                        } else {
                            echo "<tr><td>Forma de Envio</td><td>Frete via Cometa Express</td></tr>";
                        }
                        ?>
                    </table>
                  </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
