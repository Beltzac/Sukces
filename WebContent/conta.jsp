<?php
include 'session_start.php';
if (!$_SESSION['logado']) {
    header('Location: index.php');
    exit();
}
?>
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

                $("#datepicker").datepicker({
                    dateFormat: "dd/mm/yy",
                    dayNames: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"],
                    dayNamesMin: ["D", "S", "T", "Q", "Q", "S", "S"],
                    dayNamesShort: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"],
                    monthNames: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
                    monthNamesShort: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
                    nextText: "Próximo",
                    prevText: "Anterior",
                    weekHeader: "Semana",
                    changeMonth: true,
                    changeYear: true
                });

            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#endcep").mask("99.999-999");
                $("#clitelefone").mask("(99)9999-9999");
                $("#clirg").mask("99.999.999-9");
                $("#clicpf").mask("999.999.999-99");
                //Comment teste
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

        <?php
        $estados = [
            "AC" => "Acre",
            "AL" => "Alagoas",
            "AM" => "Amazonas",
            "AP" => "Amapá",
            "BA" => "Bahia",
            "CE" => "Ceará",
            "DF" => "Distrito Federal",
            "ES" => "Espirito Santo",
            "GO" => "Goiás",
            "MA" => "Maranhão",
            "MG" => "Minas Gerais",
            "MS" => "Mato Grosso do Sul",
            "MT" => "Mato Grosso",
            "PA" => "Pará",
            "PB" => "Paraíba",
            "PE" => "Pernambuco",
            "PI" => "Piauí",
            "PR" => "Paraná",
            "RJ" => "Rio de Janeiro",
            "RN" => "Rio Grande do Norte",
            "RO" => "Rondônia",
            "RR" => "Roraima",
            "RS" => "Rio Grande do Sul",
            "SC" => "Santa Catarina",
            "SE" => "Sergipe",
            "SP" => "São Paulo",
            "TO" => "Tocantins"
        ];
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
    </head>
    <body>

        <div id="main_container">

             <%@ include file="header.jsp"%>       

            <div id="main_content">
               
        
 <%@ include file="menu.jsp"%>       
 <%@ include file="menuEsquerda.jsp"%>    

                <div class="center_content">

                    <div id="accordion">
                        <h3>Status dos meus pedidos</h3>

                        <div>


                            <table border='1'>
                                <tr><td>Código</td><td>Status</td><td>Pagamento</td><td>Forma de Envio</td><td>Valor</td><td>Visualizar</td></tr>

                                <?php
                                $peddao = new PedidoDAO();
                                $cardao = new carrinhoDAO();
                                $form = $peddao->selectAllPessoa($_SESSION['id']);

                                foreach ($form as $value) {
                                    $valor = $cardao->total($value->get('cod_pedido'));
                                    echo "<tr><td>" . $value->get('cod_pedido') . "</td><td>" . $value->get('situacao') . "</td><td>" . $value->get('forma_d_pag') . "</td><td>" . $value->get('forma_d_entreg') . "</td><td> R$ ".$valor[0]. "</td><td><a href='detalhePedido.php?cod=" . $value->get('cod_pedido') . "'>Link</a></td></tr>";
                                }
                                ?>

                            </table>

                        </div>

                        <h3>Detalhes da minha conta</h3>

                        <div>
                            <form action="dao/pessoaAction.php" id="pessoa" method="post">
                                <div class="contact_form">

                                    <input type="hidden" name="acao" value="AtualizarPessoa">
                                    <input type="hidden" name="id" value="<?php echo $_SESSION['id'] ?>">
                                    <input type="hidden" name="cod_end" value="<?php echo $endereco->get('cod_end') ?>">

                                    <div class="form_row">
                                        <label class="contact"><strong>Nome completo:</strong></label>
                                        <input type="text" name="nome" class="contact_input" value="<?php echo $pessoa->get('nome') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Email:</strong></label>
                                        <input type="text" name="email" class="contact_input" value="<?php echo $pessoa->get('email') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Telefone:</strong></label>
                                        <input type="text" name="telefone" id="clitelefone" class="contact_input" value="<?php echo $pessoa->get('telefone') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>RG:</strong></label>
                                        <input type="text" name="rg" id="clirg" class="contact_input" value="<?php echo $pessoa->get('rg') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>CPF:</strong></label>
                                        <input type="text" name="cpf" id="clicpf" class="contact_input" value="<?php echo $pessoa->get('cpf') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Data de nascimento:</strong></label>
                                        <input type="text" name="nascimento" class="contact_input" id="datepicker" value="<?php echo $pessoa->get('nascimento') ?>"/>
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
                                        <input class="submit" type="submit" value="Atualizar" name=""/>

                                    </div>
                                </div>
                            </form>
                        </div>

                        <h3> Endereços</h3>

                        <div>
                            <form method="post" id="endereco" action="dao/pessoaAction.php" >
                                <div class="contact_form">

                                    <input type="hidden" name="acao" value="AtualizarEndereco">

                                    <input type="hidden" name="cod_end" value="<?php echo $endereco->get('cod_end') ?>">

                                    <div class="form_row">
                                        <label class="contact"><strong>Rua:</strong></label>
                                        <input type="text" name="rua" class="contact_input" value="<?php echo $endereco->get('rua') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>CEP:</strong></label>
                                        <input type="text" name="cep" id="endcep" class="contact_input" value="<?php echo $endereco->get('cep') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Número:</strong></label>
                                        <input type="text" name="num" class="contact_input" value="<?php echo $endereco->get('num') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Complemento:</strong></label>
                                        <input type="text" name="complemento"class="contact_input" value="<?php echo $endereco->get('complemento') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Cidade:</strong></label>
                                        <input type="text" name="cidade" class="contact_input" value="<?php echo $endereco->get('cidade') ?>"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Estado:</strong></label>                                 
                                        <select name="estado" class="contact_input" >
                                            <?php
                                            foreach ($estados as $key => $value) {

                                                if ($key == $endereco->get('estado'))
                                                    echo "<option selected value='" . $key . "'>" . $value . "</option>";
                                                else
                                                    echo "<option value='" . $key . "'>" . $value . "</option>";
                                            }
                                            ?>
                                        </select>                                    
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
