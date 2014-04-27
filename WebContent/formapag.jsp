<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${!loginBean.autenticado}">
	<c:redirect url="Controladora?action=index"/>
</c:if>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Forma de pagamento</title>
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
						Forma de Pagamento:
					</div>
                                    
					<?php
						if(empty($_POST['pagamento'])&&empty($_POST['pagamento2'])){?>
						<form method='post' action='formapag.php'>
							<INPUT TYPE='RADIO' NAME='pagamento' VALUE='credito' >Cartao de Credito<br/>
							<INPUT TYPE='RADIO' NAME='pagamento' VALUE='boleto' > Boleto Bancario<br/>
							<input type='submit' value='Continuar'>
						</form>
						<?php }
					
						if(!empty($_POST['pagamento'])&&empty($_POST['pagamento2'])){
						$form=$_POST['pagamento'];
						if($form=="credito"){ ?>
							<form action='formapag.php' method='post'>
								<select name='pagamento2'> <option value='visa'>Visa</option> 
								<option value='Mastercard'>Mastercard</option> 
								<option value='Hipercard'>Hipercard</option> 
								<option value='Diners'>Diners</option> </select> 
								<input type='submit' value='Continuar'> 
							</form>
						<?php }
						else { ?>
							<form action='formapag.php' method='post'>
								<select name='pagamento2'> 
									<option value='HSBC'>HSBC</option> 
									<option value='Itau'>Itau</option> 
								</select> 
								<input type='submit' value='Continuar'>
							</form>
						<?php }	}					
				
                                        if(!empty($_POST['pagamento2'])){
                                            $forma=$_POST['pagamento2'];
                                            ?>
                                    <form action='dao/pedidoAction.php' method='post'>
                                        <input type='hidden' name='pagamento' value='<?php echo $forma; ?>'>
                                        <select name='envio'>
                                            <option value='PAC'>PAC</option>
                                            <option value='Sedex'>Sedex</option>
                                            <option value='Frete via Cometa'>Cometa Express</option>
                                        </select>
                                        <input type='submit' value='Finalizar'>
                                    </form>
                                            
                                       <?php }
                                    ?>
			    </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
