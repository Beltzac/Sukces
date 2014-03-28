<?php
include 'session_start.php';
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Contato
		</title>
		<link rel="stylesheet" type="text/css" href="style.css" />
		<script type="text/javascript" src="js/boxOver.js"></script>
		<script src="js/jquery-2.0.2.min.js"></script>
		<script src="js/jquery.validate.min.js"></script>
		<script src="js/jquery.maskedinput.js"></script>

		<script>
			$(document).ready(function() {
				$("#contato").validate({
					// Define as regras
					rules : {
						campoNome : {
							// campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
							required : true,
							minlength : 3
						},
						campoEmail : {
							// campoEmail será obrigatório (required) e precisará ser um e-mail válido (email)
							required : true,
							email : true
						},
							campoTelefone : {
							required : true,
							minlength : 8
						},
							campoMsg : {
							required : true,
							minlength : 10
						},
						
					},
					// Define as mensagens de erro para cada regra
					messages : {
						campoNome : {
							required : "Digite o seu nome",
							minlength : "Seu nome deve ter pelo menos 3 caracteres"
						},
						campoEmail : {
							required : "Digite o seu e-mail para contato",
							email : "Digite um e-mail v&aacutelido"
						},
						
						campoTelefone : {
							required : "Digite o seu telefone",
							minlength : "Seu telefone deve ter pelo menos 8 n&uacutemeros"
						},
	
							campoMsg : {
							required : "Digite o sua mensagem",
							minlength : "Sua mensagem deve conter, no m&iacutenimo, 10 caracteres"
						}

					}
				});
			});

		</script>
<script type="text/javascript">
$(document).ready(function(){
		$("#telefone").mask("(99)9999-9999");
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
						Contate-nos
					</div>

					<div class="prod_box_big">

						<div class="center_prod_box_big">

							<div class="contact_form">
								<form id="contato" method="post" action="contato.php">
									
									
																	<div class="form_row">
										<label class="contact"><strong>Nome:</strong></label>
										<input type="text" class="contact_input" name="campoNome" />
									</div>

									<div class="form_row">
										<label class="contact"><strong>Email:</strong></label>
										<input type="text" class="contact_input" name="campoEmail" />
									</div>

									<div class="form_row">
										<label class="contact"><strong>Telefone:</strong></label>
										<input type="text" id="telefone" class="contact_input" name="campoTelefone"/>
									</div>

									<div class="form_row">
										<label class="contact"><strong>Mensagem</strong></label>
										<textarea name="campoMsg" class="contact_input"></textarea>
									</div>

									<div class="form_row">
										<input class="submit" type="submit" value="Criar" />

									</div>

								</form>
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
