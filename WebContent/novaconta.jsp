<?php
include 'session_start.php';
if (isset($_SESSION['logado']) && $_SESSION['logado']) {
    header('Location: index.php');
}
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Cadastro</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript" src="js/boxOver.js"></script>
<link rel="stylesheet" href="jquery-ui.min.css" />
<script src="js/jquery-2.0.2.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/jquery.maskedinput.js"></script>


<script>
	$(document)
			.ready(
					function() {
						$("#cliente")
								.validate(
										{
											// Define as regras
											rules : {
												nome : {
													// campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
													required : true,
													minlength : 2
												},
												email : {
													// campoEmail será obrigatório (required) e precisará ser um e-mail válido (email)
													required : true,
													email : true
												},
												senha : {
													required : true,
													minlength : 6
												},												
												endereco : {
													required : true,
													minlength : 5
												},
												numero : {
													required : true,
													minlength : 1
												},											
												telefone1 : {
													required : true,
													minlength : 10
												},
												telefone2 : {													
													minlength : 10
												},
												cep : {
													required : true,
													minlength : 8
												},
												cpf : {
													required : true,
													minlength : 11
												}

											},
											// Define as mensagens de erro para cada regra
											messages : {
												nome : {
													required : "Digite o seu nome",
													minlength : "O seu nome deve conter, no m&iacutenimo, 3 caracteres"
												},
												email : {
													required : "Digite o seu e-mail para contato",
													email : "Digite um e-mail v&aacutelido"
												},
												senha : {
													required : "Digite sua senha",
													minlength : "Sua senha deve conter, no m&iacutenimo, 6 caracteres"
												},												
												endereco : {
													required : "Digite sua rua",
													minlength : "Sua rua deve conter, no m&iacutenimo, 5 caracteres"
												},
												numero : {
													required : "Digite o n&uacutemero",
													minlength : "Seu n&uacutemero deve conter, no m&iacutenimo, 1 caracter"
												},												
												telefone1 : {
													required : "Digite seu telefone",
													minlength : ""
												},
												telefone2 : {													
													minlength : ""
												},
												cep : {
													required : "Digite seu CEP",
													minlength : ""
												},
												cpf : {
													required : "Digite seu CPF",
													minlength : ""
												}

											}
										});
					});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		//$("#campoNascimento").mask("99/99/9999");
		$("#cpf").mask("999.999.999-99");
		$("#cep").mask("99.999-999");
		$("#telefone1").mask("(99)9999-9999");
		$("#telefone2").mask("(99)9999-9999");
		$("#campoRg").mask("99.999.999-9");
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
				<div class="center_title_bar">Nova conta</div>

				<div class="prod_box_big">

					<div class="center_prod_box_big">

						<div class="contact_form">
							<form id="cliente" method="post" action="DAO/pessoaAction.php">

								<input type="hidden" name="acao" value="novo">

								<div class="form_row">
									<label class="contact"><strong>Nome completo:</strong></label>
									<input type="text" class="contact_input" name="nome" />
								</div>

								<div class="form_row">
									<label class="contact"><strong>Email:</strong></label> <input
										type="text" class="contact_input" name="email" />
								</div>

								<div class="form_row">
									<label class="contact"><strong>Senha:</strong></label> <input
										type="password" class="contact_input" name="senha" />
								</div>


								<div class="form_row">
									<label class="contact"><strong>Telefone 1:</strong></label> <input
										type="text" id="telefone1" class="contact_input"
										name="telefone1" />
								</div>
								
								<div class="form_row">
									<label class="contact"><strong>Telefone 2:</strong></label> <input
										type="text" id="telefone2" class="contact_input"
										name="telefone2" />
								</div>
							

								<div class="form_row">
									<label class="contact"><strong>CPF:</strong></label> <input
										type="text" id="cpf" class="contact_input"
										name="cpf" />
								</div>
								
							    <div class="form_row">
									<label class="contact"><strong>CNPJ:</strong></label> <input
										type="text" id="cpf" class="contact_input"
										name="cnpj" />
								</div>
								
								<div class="form_row">
									<label class="contact"><strong>CEP:</strong></label> <input
										type="text" id="cep" class="contact_input"
										name="cep" />
								</div>							

								<div class="form_row">
									<label class="contact"><strong>Endere�o:</strong></label> <input
										type="text" class="contact_input" name="endereco" />
								</div>	
								
								<div class="form_row">
									<label class="contact"><strong>N�mero:</strong></label> <input
										type="text" class="contact_input" name="numero" />
								</div>															

								<div class="form_row">
									<input class="submit" type="submit" value="Criar" />
								</div>

							</form>
						</div>

					</div>

				</div>
			</div>
			<!-- center -->


			<%@ include file="menuDireita.jsp"%>

		</div>
		<!-- main index -->



		<%@ include file="footer.html"%>
	</div>
</body>
</html>
