<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Minha conta - Lolwtf Mobile</title>
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
<!-- 
        <?php

        require_once 'DAO/PessoaDAO.php';
        require_once 'DAO/EnderecoDAO.php';
        require_once 'DAO/PedidoDAO.php';
        require_once 'DAO/carrinhoDAO.php';

        $pessoa = new Pessoa();
        $endereco = new Endereco();
        
        if (isset($_SESSION['id'])) {
            $pessoaDAO = new PessoaDAO();
            $select = $pessoaDAO->selectByCod($_SESSION['id']);
            if ($select) {
                $pessoa = $select;

                $enderecoDAO = new EnderecoDAO();
                $select2 = $enderecoDAO->selectByCod($pessoa->get('cod_end'));
                if ($select2) {
                    $endereco = $select2;
                } else {
                    header('Location: index.php');
                }
            } else {
                header('Location: index.php');
            }
        } else {
            header('Location: index.php');
        }
        ?>     
         -->
    </head>
    <body>

        <div id="main_container">

             <%@ include file="header.jsp"%>
             <% 	
				if(!loginBean.isAutenticado()) response.sendRedirect("index.jsp");
			%>       

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
                                <?php
                                $peddao = new PedidoDAO();
                                $cardao = new carrinhoDAO();
                                $form = $peddao->selectAllPessoa($_SESSION['id']);

                                foreach ($form as $value) {
                                    $valor = $cardao->total($value->get('cod_pedido'));
                                    echo "<tr><td>" . $value->get('cod_pedido') . "</td><td>" . $value->get('situacao') . "</td><td>" . $value->get('forma_d_pag') . "</td><td>" . $value->get('forma_d_entreg') . "</td><td> R$ ".$valor[0]. "</td><td><a href='detalhePedido.php?cod=" . $value->get('cod_pedido') . "'>Link</a></td></tr>";
                                }
                                ?>
 -->
                            </table>

                        </div>
                        
                        <%
                        
                        
                        
                        
                        %>
                        

                        <h3>Detalhes da minha conta</h3>

                        <div>
                            <form action="action/atualizarUsuario.jsp" id="pessoa" method="post">
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
                                        <input type="text" name="telefone" id="clitelefone" class="contact_input" value="${loginBean.usuario.telefone1}"/>
                                    </div>
                                    
                                     <div class="form_row">
                                        <label class="contact"><strong>Telefone 2:</strong></label>
                                        <input type="text" name="telefone" id="clitelefone" class="contact_input" value="${loginBean.usuario.telefone2}"/>
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
                                        <input type="text" name="estado" id="endcep" class="contact_input" value="${loginBean.usuario.estado}"/>
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

                        

                    </div>

                </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
