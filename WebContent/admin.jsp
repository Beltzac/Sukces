<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${!loginBean.autenticado || !loginBean.usuario.administrador}">
	<c:redirect url="Controladora?action=index"/>
</c:if>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>AdministraÁ„o</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript" src="js/boxOver.js"></script>
<link rel="stylesheet" href="jquery-ui.min.css" />

<script src="js/jquery-2.0.2.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/jquery.maskedinput.js"></script>
<script src="js/boxOver.js"></script>


<script>
	$(function() {
		$("#accordion").accordion({active: ${active == null? 0 : active} });

		$(document).ready(function() {
			$("#datepicker2").datepicker({
				onSelect : function(dateText, inst) {
					alert(dateText);
					document.getElementById('datepicker2').value = dateText;
				}
			});
		});
		$(document).ready(function() {
			$("#thedate").datepicker({
				onSelect : function(dateText, diferente) {
					alert(dateText);
					document.getElementById('thedate').value = dateText;
				}
			});
		});

		$("#datepicker").datepicker(
				{
					dateFormat : "dd/mm/yy",
					dayNames : [ "Domingo", "Segunda", "Ter√ßa", "Quarta",
							"Quinta", "Sexta", "S√°bado" ],
					dayNamesMin : [ "D", "S", "T", "Q", "Q", "S", "S" ],
					dayNamesShort : [ "Dom", "Seg", "Ter", "Qua", "Qui", "Sex",
							"S√°b" ],
					monthNames : [ "Janeiro", "Fevereiro", "Mar√ßo", "Abril",
							"Maio", "Junho", "Julho", "Agosto", "Setembro",
							"Outubro", "Novembro", "Dezembro" ],
					monthNamesShort : [ "Jan", "Fev", "Mar", "Abr", "Mai",
							"Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez" ],
					nextText : "Pr√≥ximo",
					prevText : "Anterior",
					weekHeader : "Semana",
					changeMonth : true,
					changeYear : true
				});

		$("#datepicker2").datepicker(
				{
					dateFormat : "dd/mm/yy",
					dayNames : [ "Domingo", "Segunda", "Ter√ßa", "Quarta",
							"Quinta", "Sexta", "S√°bado" ],
					dayNamesMin : [ "D", "S", "T", "Q", "Q", "S", "S" ],
					dayNamesShort : [ "Dom", "Seg", "Ter", "Qua", "Qui", "Sex",
							"S√°b" ],
					monthNames : [ "Janeiro", "Fevereiro", "Mar√ßo", "Abril",
							"Maio", "Junho", "Julho", "Agosto", "Setembro",
							"Outubro", "Novembro", "Dezembro" ],
					monthNamesShort : [ "Jan", "Fev", "Mar", "Abr", "Mai",
							"Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez" ],
					nextText : "Pr√≥ximo",
					prevText : "Anterior",
					weekHeader : "Semana",
					changeMonth : true,
					changeYear : true
				});

		$("#thedate").datepicker(
				{
					dateFormat : "dd/mm/yy",
					dayNames : [ "Domingo", "Segunda", "Ter√ßa", "Quarta",
							"Quinta", "Sexta", "S√°bado" ],
					dayNamesMin : [ "D", "S", "T", "Q", "Q", "S", "S" ],
					dayNamesShort : [ "Dom", "Seg", "Ter", "Qua", "Qui", "Sex",
							"S√°b" ],
					monthNames : [ "Janeiro", "Fevereiro", "Mar√ßo", "Abril",
							"Maio", "Junho", "Julho", "Agosto", "Setembro",
							"Outubro", "Novembro", "Dezembro" ],
					monthNamesShort : [ "Jan", "Fev", "Mar", "Abr", "Mai",
							"Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez" ],
					nextText : "Pr√≥ximo",
					prevText : "Anterior",
					weekHeader : "Semana",
					changeMonth : true,
					changeYear : true
				});

	});
	var currentDate = $(".selector").datepicker("getDate");
	document.write(currentDate);
	//document.getElementsByName()
</script>

<script>
	$(document)
			.ready(
					function() {
						$("#produto")
								.validate(
										{
											// Define as regras
											rules : {
												nome : {
													// campoNome ser√° obrigat√≥rio (required) e ter√° tamanho m√≠nimo (minLength)
													required : true,
													minlength : 3
												},
												descricao : {
													required : true,
													minlength : 10
												},
											},
											// Define as mensagens de erro para cada regra
											messages : {
												nome : {
													required : "Digite o seu nome",
													minlength : "O nome deve ter pelo menos 3 caracteres"
												},
												descricao : {
													required : "Digite o sua mensagem",
													minlength : "Sua mensagem deve conter, no m&iacutenimo, 10 caracteres"
												}

											}
										});
					});
</script>
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
													// campoNome ser√° obrigat√≥rio (required) e ter√° tamanho m√≠nimo (minLength)
													required : true,
													minlength : 3
												},
												email : {
													// campoEmail ser√° obrigat√≥rio (required) e precisar√° ser um e-mail v√°lido (email)
													required : true,
													email : true
												},
												telefone : {
													required : true,
													minlength : 8
												},
												rg : {
													required : true,
													minlength : 9
												},
												cep : {
													required : true,
													minlength : 8
												},
												cpf : {
													required : true,
													minlength : 11
												},
												nascimento : {
													required : true,
													minlength : 8
												}
											},
											// Define as mensagens de erro para cada regra
											messages : {
												nome : {
													required : "Digite o seu nome",
													minlength : "O nome deve ter pelo menos 3 caracteres"
												},
												email : {
													required : "Digite o seu e-mail para contato",
													email : "Digite um e-mail v&aacutelido"
												},
												telefone : {
													required : "Digite o seu telefone",
													minlength : "Seu telefone deve ter pelo menos 8 n&uacutemeros"
												},
												rg : {
													required : "Digite seu rg",
													minlength : "O seu rg deve conter, no m&iacutenimo, 9 caracteres"
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
<script>
	$(document)
			.ready(
					function() {
						$("#Categoria")
								.validate(
										{
											// Define as regras
											rules : {
												nome : {
													// campoNome ser√° obrigat√≥rio (required) e ter√° tamanho m√≠nimo (minLength)
													required : true,
													minlength : 3
												}
											},
											// Define as mensagens de erro para cada regra
											messages : {
												nome : {
													required : "Digite o nome da Categoria",
													minlength : "O nome da Categoria deve ter pelo menos 3 caracteres"
												}
											}
										});
					});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#clitelefone").mask("(99)9999-9999");
		$("#prodpreco").mask("99999,99");
		$("#prodestoque").mask("999");
		$("#clicpf").mask("999.999.999-99");
		$("#clicep").mask("99.999-999");
		$("#clirg").mask("99.999.999-9");
		$("#prodpeso").mask("99999g");
		$("#proddimensao").mask("999x999x999");
	});
</script>
</head>
<body onLoad="updateCat()">



	<div id="main_container">

		<%@ include file="header.jsp"%>

		<div id="main_content">


			<%@ include file="menu.jsp"%>
			<%@ include file="menuEsquerda.jsp"%>


			<div class="center_content">

				<div id="accordion">

					<h3>Produtos</h3>
					<div>
						<div class="contact_form">
							<form id="produto" method="post"
								action="Controladora?action=produto"
								enctype="multipart/form-data">

 							<div class="product_img_big">
                         		  <img src="${produto.imagemURL}" alt="${produto.nome}" class="imgAdmin" >
                            </div>

								<input type="hidden" value="${produto.id}" name="id" />



								<div class="form_row">
									<label class="contact"><strong>Categoria:</strong></label>											
									
									
									 <select id="categoriaSelect" name="categoria">
										 <c:forEach items="${listaCategorias}" var="item"  varStatus="cont">      
        	                            	<option value="${item.id}">${item.nome}</option>  
        							 	</c:forEach>
									</select>

								</div>


								<div class="form_row">
									<label class="contact"><strong>Nome:</strong></label> <input
										type="text" class="contact_input" name="nome"
										value="${produto.nome}" />
								</div>

								<div class="form_row">
									<label class="contact"><strong>PreÁo:</strong></label> <input
										type="text" class="contact_input" name="preco"
										value="${produto.preco}" />
								</div>

								<div class="form_row">
									<label class="contact"><strong>DescriÁ„o:</strong></label> <input
										type="text" class="contact_input" name="descricao"
										value="${produto.descricao}" />
								</div>


								<div class="form_row">
									<label class="contact"><strong>Imagem:</strong></label> <input
										type="file" class="contact_input" name="imagem" />
								</div>


								<div class="form_row">
									<input class="submit" type="submit" value="Novo" name="novo" />
									<input class="submit" type="submit" value="Atualizar"
										name="atualizar" /> <input class="submit" type="submit"
										value="Deletar" name="deletar" />

								</div>
							</form>

						</div>
					</div>
					<h3>Clientes</h3>

					<div>
						<div class="contact_form">
							<form id="cliente" method="post" action="Controladora?action=atualizarUsuario">
								
								<input type="hidden" value="${usuario.id}" name="id" />

								<div class="form_row">
									<label class="contact"><strong>Nome completo:</strong></label>
									<input type="text" class="contact_input" name="nome" value="${usuario.nome}"/>
								</div>

								<div class="form_row">
									<label class="contact"><strong>Email:</strong></label> <input
										type="text" class="contact_input" name="email" value="${usuario.email}" />
								</div>

								<div class="form_row">
									<label class="contact"><strong>Senha:</strong></label> <input
										type="password" class="contact_input" name="senha" />
								</div>


								<div class="form_row">
									<label class="contact"><strong>Telefone 1:</strong></label> <input
										type="text" id="telefone1" class="contact_input"
										name="telefone1" value="${usuario.telefone1}" />
								</div>
								
								<div class="form_row">
									<label class="contact"><strong>Telefone 2:</strong></label> <input
										type="text" id="telefone2" class="contact_input"
										name="telefone2" value="${usuario.telefone2}"/>
								</div>
							

								<div class="form_row">
									<label class="contact"><strong>CPF:</strong></label> <input
										type="text" id="cpf" class="contact_input"
										name="cpf" value="${usuario.cpf}"/>
								</div>
								
							    <div class="form_row">
									<label class="contact"><strong>CNPJ:</strong></label> <input
										type="text" id="cnpj" class="contact_input"
										name="cnpj" value="${usuario.cnpj}"/>
								</div>
								
								<div class="form_row">
									<label class="contact"><strong>CEP:</strong></label> <input
										type="text" id="cep" class="contact_input"
										name="cep" value="${usuario.cep}"/>
								</div>	
														
           							<div class="form_row">
                                        <label class="contact"><strong>Cidade:</strong></label>
                                        <input type="text" name="cidade" class="contact_input" value="${usuario.cidade}"/>
                                    </div>
                                    
                                     <script>       
            							$(function() {           
           									 $('#estado').val( "${usuario.estado}" );
           								 });
     								</script>

                                    <div class="form_row">
                                        <label class="contact"><strong>Estado:</strong></label>                                       
                                        <select name="estado" >								
										<option value="pr">Paran·</option>
										<option value="ac">Acre</option>
										<option value="al">Alagoas</option>
										<option value="ap">Amap·</option>
										<option value="am">Amazonas</option>
										<option value="ba">Bahia</option>
										<option value="ce">Cear·</option>
										<option value="df">Distrito Federal</option>
										<option value="es">Espirito Santo</option>
										<option value="go">Goi·s</option>
										<option value="ma">Maranh„o</option>
										<option value="ms">Mato Grosso do Sul</option>
										<option value="mt">Mato Grosso</option>
										<option value="mg">Minas Gerais</option>
										<option value="pa">Par·</option>
										<option value="pb">ParaÌba</option>								
										<option value="pe">Pernambuco</option>
										<option value="pi">PiauÌ</option>
										<option value="rj">Rio de Janeiro</option>
										<option value="rn">Rio Grande do Norte</option>
										<option value="rs">Rio Grande do Sul</option>
										<option value="ro">RondÙnia</option>
										<option value="rr">Roraima</option>
										<option value="sc">Santa Catarina</option>
										<option value="sp">S„o Paulo</option>
										<option value="se">Sergipe</option>
										<option value="to">Tocantins</option>
									</select>
                                    </div>
								<div class="form_row">
									<label class="contact"><strong>rua:</strong></label> <input
										type="text" class="contact_input" name="rua" value="${usuario.rua}"/>
								</div>	
								
								<div class="form_row">
									<label class="contact"><strong>N˙mero:</strong></label> <input
										type="text" class="contact_input" name="numero" value="${usuario.numero}"/>
								</div>															

										<div class="form_row">								
									<input class="submit" type="submit" value="Atualizar"
										name="atualizar" /> <input class="submit" type="submit"
										value="Deletar" name="deletar" />

								</div>
							</form>
							
						</div>
					</div>

					<h3>Categorias</h3>

					<div>
						<div class="contact_form">

							<form id="Categoria" method="post"
								action="Controladora?action=categoria" name="Categoria">
								<div class="form_row">

									<select id="categoriaSelect" name="id" onChange="updateCat()">
										<c:forEach items="${listaCategorias}" var="item"  varStatus="cont">      
	        	                            <option value="${item.id}">${item.nome}</option>  
    	    							 </c:forEach>
									</select>
									<script>
										function updateCat() {
											item = document
													.getElementById("categoriaSelect");
											categoria = item.options[item.selectedIndex].innerHTML;
											document
													.getElementById("categoriaNome").value = categoria;
										}
									</script>
								</div>

								<div class="form_row">
									<label class="contact"><strong>Nome:</strong></label> <input
										type="text" id="categoriaNome" name="nome"
										class="contact_input" value="" />
								</div>

								<div class="form_row">
									<input class="submit" type="submit" value="Atualizar"
										name="atualizar" /> <input class="submit" type="submit"
										value="Novo" name="novo" /> <input class="submit"
										type="submit" value="Deletar" name="deletar" />
								</div>

							</form>

						</div>
					</div>

					<h3>RelatÛrios</h3>

					<div>
						<div>
							<form method='post' action='relatorios.php'>
								<div class='form_row'>
									<label class='contact'><strong>De: </strong></label>
									<div type="text" id="datepicker22">
										<input type="text" class="contact_input" id="datepicker2"
											name="datepicker2" />
									</div>
								</div>
								<div class='form_row'>
									<label class='contact'><strong>AtÈ: </strong></label>
									<div type="hidden" id="thedate1">
										<input type="text" class="contact_input" id="thedate"
											name="thedate" />
									</div>
								</div>
								<br /> <br /> <input type='radio' name='op' value='op1'>
								Clientes <br /> <input type='radio' name='op' value='op3'>
								Venda <br /> <input type='submit' value='OK'>
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
