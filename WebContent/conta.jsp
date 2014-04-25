<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${!loginBean.autenticado}">
	<c:redirect url="Controladora?action=index"/>
</c:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Minha conta - Sukces</title>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <script type="text/javascript" src="js/boxOver.js"></script>

        <link rel="stylesheet" href="jquery-ui.min.css" />
        <script src="js/jquery-2.0.2.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/jquery.validate.min.js"></script>
        <script src="js/jquery.maskedinput.js"></script>

        <script>
            $(function() {
                $("#accordion").accordion();              

            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#cep").mask("99.999-999");
                $("#telefone1").mask("(99)9999-9999");
                $("#telefone2").mask("(99)9999-9999");               
                $("#cpf").mask("999.999.999-99");    
                $("#cnpj").mask("99.999.999.9999-99");            
            });
        </script>
        <script>
            $(document).ready(function() {
                $("#pessoa").validate({
                    // Define as regras
                    rules: {
                        nome: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
                            required: true,
                            minlength: 3
                        },
                        senha: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
                            required: false,
                            minlength: 6
                        },
                        senha2: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
                            required: false,
                            minlength: 6
                        },
                        senhaatual: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
                            required: false,
                            minlength: 6
                        },
                        email: {
                            required: true,
                            email: true
                        },
                        cnpj : {
							required : true,
							minlength : 14
						}
                    },
                    // Define as mensagens de erro para cada regra
                    messages: {
                        nome: {
                            required: "Digite o seu nome",
                            minlength: "O nome deve ter pelo menos 3 caracteres"
                        },
                        senha: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
                            required: " ",
                            minlength: "Sua senha deve ter pelo menos 6 caracteres"
                        },
                        senha2: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
                            required: " ",
                            minlength: "Sua senha deve ter pelo menos 6 caracteres"
                        },
                        senhaatual: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)sfasf
                            required: " ",
                            minlength: "Sua senha deve ter pelo menos 6 caracteres"
                        },
                        email: {
                            required: "Digite o seu e-mail para contato",
                            email: "Digite um e-mail v&aacutelido"
                        }

                    }
                });
            });

        </script>

    </head>
    <body>

        <div id="main_container">

             <%@ include file="header.jsp"%>
    
	   <script>        

            $(function() {           
            $('#estado').val( "${loginBean.usuario.estado}" );
            });
        </script>

            <div id="main_content">
               
        
 <%@ include file="menu.jsp"%>       
 <%@ include file="menuEsquerda.jsp"%>    

                <div class="center_content">

                    <div id="accordion">
                        <h3>Status dos meus pedidos</h3>

                        <div>


                            <table border='1'>
                                <tr><td>C�digo</td><td>Status</td><td>Pagamento</td><td>Forma de Envio</td><td>Valor</td><td>Visualizar</td></tr>
<!-- 
            -->
                            </table>

                        </div>
                    

                        <h3>Detalhes da minha conta</h3>

                        <div>
                            <form action="Controladora?action=atualizarUsuario" id="pessoa" method="post">
                                <div class="contact_form">
                                   
                                    <input type="hidden" name="id" value="${loginBean.usuario.id}">                                   

                                    <div class="form_row">
                                        <label class="contact"><strong>Nome completo:</strong></label>
                                        <input type="text" name="nome" class="contact_input" value="${loginBean.usuario.nome}"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Email:</strong></label>
                                        <input type="text" name="email" class="contact_input" value="${loginBean.usuario.email}"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Telefone 1:</strong></label>
                                        <input type="text" name="telefone1" id="telefone1" class="contact_input" value="${loginBean.usuario.telefone1}"/>
                                    </div>
                                    
                                     <div class="form_row">
                                        <label class="contact"><strong>Telefone 2:</strong></label>
                                        <input type="text" name="telefone2" id="telefone2" class="contact_input" value="${loginBean.usuario.telefone2}"/>
                                    </div>  

                                    <div class="form_row">
                                        <label class="contact"><strong>CPF:</strong></label>
                                        <input type="text" name="cpf" id="cpf" class="contact_input" value="${loginBean.usuario.cpf}"/>
                                    </div>
                                    
                                     <div class="form_row">
                                        <label class="contact"><strong>CNPJ:</strong></label>
                                        <input type="text" name="cnpj" id="cnpj" class="contact_input" value="${loginBean.usuario.cnpj}"/>
                                    </div>
                                    
                                    <div class="form_row">
                                        <label class="contact"><strong>CEP:</strong></label>
                                        <input type="text" name="cep" id="cep" class="contact_input" value="${loginBean.usuario.cep}"/>
                                    </div>
                                    
                                     <div class="form_row">
                                        <label class="contact"><strong>Rua:</strong></label>
                                        <input type="text" name="rua" class="contact_input" value="${loginBean.usuario.rua}"/>
                                    </div>
                                    
                                   <div class="form_row">
                                        <label class="contact"><strong>Cidade:</strong></label>
                                        <input type="text" name="cidade" class="contact_input" value="${loginBean.usuario.cidade}"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Estado:</strong></label>
                                           <select name="estado" id="estado" class="form-control" >								
								<option value="pr">Paran�</option>
								<option value="ac">Acre</option>
								<option value="al">Alagoas</option>
								<option value="ap">Amap�</option>
								<option value="am">Amazonas</option>
								<option value="ba">Bahia</option>
								<option value="ce">Cear�</option>
								<option value="df">Distrito Federal</option>
								<option value="es">Espirito Santo</option>
								<option value="go">Goi�s</option>
								<option value="ma">Maranh�o</option>
								<option value="ms">Mato Grosso do Sul</option>
								<option value="mt">Mato Grosso</option>
								<option value="mg">Minas Gerais</option>
								<option value="pa">Par�</option>
								<option value="pb">Para�ba</option>								
								<option value="pe">Pernambuco</option>
								<option value="pi">Piau�</option>
								<option value="rj">Rio de Janeiro</option>
								<option value="rn">Rio Grande do Norte</option>
								<option value="rs">Rio Grande do Sul</option>
								<option value="ro">Rond�nia</option>
								<option value="rr">Roraima</option>
								<option value="sc">Santa Catarina</option>
								<option value="sp">S�o Paulo</option>
								<option value="se">Sergipe</option>
								<option value="to">Tocantins</option>
							</select>
                                    
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>N�mero:</strong></label>
                                        <input type="text" name="numero" class="contact_input" value="${loginBean.usuario.numero}"/>
                                    </div>


                                    <div class="form_row">
                                        <input class="submit" type="submit" value="Atualizar" name=""/>

                                    </div>
                                </div>
                            </form>
                        </div>

                        <h3>Alterar senha</h3>

                        <div>
                            <form action="action/atualizarUsuario.jsp" id="pessoa" method="post">
                                <div class="contact_form">
                                
                                 <div class="form_row">
                                        <label class="contact"><strong>Senha atual:</strong></label>
                                        <input type="password" class="contact_input" name="senhaatual" />
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Nova senha:</strong></label>
                                        <input type="password" class="contact_input" name="senha" />
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Confirme senha:</strong></label>
                                        <input type="password" class="contact_input" name="senha2" />
                                    </div>
                                    
                                    <div class="form_row">                                    
                                        <input class="submit" type="submit" value="Atualizar" name=""/>
                                    </div>
                                
                                </div>                                
                            </form> 
                                
                        </div>

                    </div>

                </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
