<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${!loginBean.autenticado || !loginBean.usuario.administrador}">
	<c:redirect url="Controladora?action=index"/>
</c:if>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Administração</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet" href="jquery-ui.min.css" />
<script src="js/jquery-2.0.2.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/jquery.maskedinput.js"></script>

<script>

	$(function() {           
   		$('#estado').val( "${usuario.estado}" );
    });

	$(function() {           
   		$('#categoriaSelect').val( "${produto.categoria}" );
    });
    
	$(function() {
		$("#accordion").accordion({active: ${active == null? 0 : active} });

		$(document).ready(function() {
			$("#data1").datepicker({
				onSelect : function(dateText, inst) {
					alert(dateText);
					document.getElementById('data1').value = dateText;
				}
			});
		});
		$(document).ready(function() {
			$("#data2").datepicker({
				onSelect : function(dateText, diferente) {
					alert(dateText);
					document.getElementById('data2').value = dateText;
				}
			});
		});
	
		$("#data1").datepicker({
		    dateFormat: 'dd/mm/yy',
		    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
		    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
		    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
		    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		    nextText: 'Próximo',
		    prevText: 'Anterior',
			weekHeader : "Semana",
			changeMonth : true,
			changeYear : true
		});		

		$("#data2").datepicker({
		    dateFormat: 'dd/mm/yy',
		    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
		    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
		    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
		    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		    nextText: 'Próximo',
		    prevText: 'Anterior',
		    weekHeader : "Semana",
			changeMonth : true,
			changeYear : true
		});	
		
	});	
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
													// campoNome serÃ¡ obrigatÃ³rio (required) e terÃ¡ tamanho mÃ­nimo (minLength)
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
													required : "Digite a descrição",
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
													// campoNome serÃ¡ obrigatÃ³rio (required) e terÃ¡ tamanho mÃ­nimo (minLength)
													required : true,
													minlength : 3
												},
												email : {
													// campoEmail serÃ¡ obrigatÃ³rio (required) e precisarÃ¡ ser um e-mail vÃ¡lido (email)
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
													// campoNome serÃ¡ obrigatÃ³rio (required) e terÃ¡ tamanho mÃ­nimo (minLength)
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
		$("#telefone1").mask("(99)9999-9999");
		$("#telefone2").mask("(99)9999-9999");
		$("#cpf").mask("999.999.999-99");
		$("#cep").mask("99.999-999");
		$("#cnpj").mask("99.999.999.9999-99");
	});
</script>
</head>
<body onLoad="updateCat()">



	<div id="main_container">

		<%@ include file="header.jsp"%>
		
		  <script> 
				            
        </script>

		<div id="main_content">


			<%@ include file="menu.jsp"%>
			<%@ include file="menuEsquerda.jsp"%>


			<div class="center_content">

				<div id="accordion">

					<h3>Produtos</h3>
					<div>
						<div class="contact_form">	
						
						<form id="cliente" method="post" action="Controladora?action=pesquisaProduto">
								<div class="form_row">
									<label class="contact"><strong>Pesquisar:</strong></label>
									<input type="text" class="contact_input" name="pesquisa" value=""/>
								</div>
								<div class="form_row">
									<input class="submit" type="submit" value="Ir"/>
							    </div>
						</form>
						
						<hr>
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
									<label class="contact"><strong>Preço:</strong></label> <input
										type="text" class="contact_input" id="preco" name="preco"
										value="${produto.preco}" />
								</div>

								<div class="form_row">
									<label class="contact"><strong>Descrição:</strong></label>
									<textarea class="contact_input" name="descricao" >${produto.descricao}</textarea>
								</div>


								<div class="form_row">
									<label class="contact"><strong>Imagem:</strong></label> <input
										type="file" class="contact_input" name="imagem" />
								</div>


								<div class="form_row">
									<c:if test="${empty produto}">
									<input class="submit" type="submit" value="Novo" name="novo" />
									</c:if>
									<c:if test="${not empty produto}">
										<input class="submit" type="submit" value="Atualizar" name="atualizar" />
										<input class="submit" type="submit"	value="Deletar" name="deletar" />
									</c:if>
								</div>
							</form>

						</div>
					</div>
					<h3>Clientes</h3>
					
					   

					<div>
						<div class="contact_form">
						<form id="cliente" method="post" action="Controladora?action=usuarios">
								<div class="form_row">
									<label class="contact"><strong>Pesquisar:</strong></label>
									<input type="text" class="contact_input" name="pesquisa" value=""/>
								</div>
								<div class="form_row">
									<input class="submit" type="submit" value="Ir"/>
							    </div>
						</form>						
						
						<c:if test="${not empty usuario}">
						
						<hr>
						
							<form id="cliente" method="post" action="Controladora?action=atualizarUsuarioAdmin">
								
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
                                                                        

                                    <div class="form_row">
                                        <label class="contact"><strong>Estado:</strong></label>                                       
                                        <select name="estado" id="estado">								
										<option value="pr">Paraná</option>
										<option value="ac">Acre</option>
										<option value="al">Alagoas</option>
										<option value="ap">Amapá</option>
										<option value="am">Amazonas</option>
										<option value="ba">Bahia</option>
										<option value="ce">Ceará</option>
										<option value="df">Distrito Federal</option>
										<option value="es">Espirito Santo</option>
										<option value="go">Goiás</option>
										<option value="ma">Maranhão</option>
										<option value="ms">Mato Grosso do Sul</option>
										<option value="mt">Mato Grosso</option>
										<option value="mg">Minas Gerais</option>
										<option value="pa">Pará</option>
										<option value="pb">Paraíba</option>								
										<option value="pe">Pernambuco</option>
										<option value="pi">Piauí</option>
										<option value="rj">Rio de Janeiro</option>
										<option value="rn">Rio Grande do Norte</option>
										<option value="rs">Rio Grande do Sul</option>
										<option value="ro">Rondônia</option>
										<option value="rr">Roraima</option>
										<option value="sc">Santa Catarina</option>
										<option value="sp">São Paulo</option>
										<option value="se">Sergipe</option>
										<option value="to">Tocantins</option>
									</select>
                                    </div>
								<div class="form_row">
									<label class="contact"><strong>Rua:</strong></label> <input
										type="text" class="contact_input" name="rua" value="${usuario.rua}"/>
								</div>	
								
								<div class="form_row">
									<label class="contact"><strong>Número:</strong></label> <input
										type="text" class="contact_input" name="numero" value="${usuario.numero}"/>
								</div>
								<div class="form_row">
									<label class="contact"><strong>Admin:</strong></label> <input
										type="checkbox" class="contact" name="administrador" ${usuario.administrador?'checked':''}  value="true"/>
								</div>									
								
										<div class="form_row">								
									<input class="submit" type="submit" value="Atualizar"
										name="atualizar" /> <input class="submit" type="submit"
										value="Deletar" name="deletar" />

								</div>
							</form>
						</c:if>
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
											item = document.getElementById("categoriaSelect");
											categoria = item.options[item.selectedIndex].innerHTML;
											document.getElementById("categoriaNome").value = categoria;
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
										
					<h3>Pedidos</h3>
					<div>
						<div>
						Categoria:
							<form method='post' action='Controladora?action=admin&sub=pedido'>							
								<br /> <br /> 
								<input type='radio' name='option' value='AGUARDANDO_APROVACAO' checked> Aguardando aprovação <br /> 
								<input type='radio' name='option' value='AGUARDANDO_PAGAMENTO'> Aguardando pagamento <br />							
								<input type='radio' name='option' value='AGUARDANDO_CONFECCAO'> Aguardando confecção <br />
								<input type='radio' name='option' value='ENVIADO'> Enviado <br />   
								<input type='submit' value='Pesquisar'>
							</form>
							
							<table>
								<thead>
									<tr>										
										<td>Pedido</td>
										<td>Cliente</td>
										<td>Total</td>										
										<td>Detalhes</td>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${listaPedidos}" var="pedido">
									<tr>
										<td>${pedido.id}</td>
										<td>${pedido.usuario}</td>
										<td><fmt:formatNumber value="${pedido.total}" type="currency"/></td>										
										<td><a href="Controladora?action=detalhesPedido&id=${pedido.id}">Detalhes</a></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							
						</div>
					</div>
					
					<h3>Relatórios</h3>
					<div>
						<div>
							<form method='post' action='relatorio'>
								<br /> <br /> 
								<input type='radio' name='option' value='usuarios' checked> Usuários <br /> 
								<input type='radio' name='option' value='produtos'> Produtos <br /> 
								<input type='submit' value='OK'>
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
