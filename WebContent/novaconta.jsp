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
            $(document).ready(function() {
                $("#cliente").validate({
                    // Define as regras
                    rules: {
                        campoNome: {
                            // campoNome será obrigatório (required) e terá tamanho mínimo (minLength)
                            required: true,
                            minlength: 2
                        },
                        campoEmail: {
                            // campoEmail será obrigatório (required) e precisará ser um e-mail válido (email)
                            required: true,
                            email: true
                        },
                        campoSenha: {
                            required: true,
                            minlength: 6
                        },
                        campoRg: {
                            required: true,
                            minlength: 9
                        },
                        campoRua: {
                            required: true,
                            minlength: 5
                        },
                        campoNumero: {
                            required: true,
                            minlength: 1
                        },
                        campoComplemento: {
                            required: false,
                            minlength: 0
                        },
                        campoCidade: {
                            required: true,
                            minlength: 3
                        },
                        campoEstado: {
                            required: true

                        },
                        campoTelefone: {
                            required: true,
                            minlength: 10
                        },
                        campoCep: {
                            required: true,
                            minlength: 8
                        },
                        campoCpf: {
                            required: true,
                            minlength: 11
                        },
                        campoNascimento: {
                            required: true,
                            minlength: 8
                        }

                    },
                    // Define as mensagens de erro para cada regra
                    messages: {
                        campoNome: {
                            required: "Digite o seu nome",
                            minlength: "O seu nome deve conter, no m&iacutenimo, 3 caracteres"
                        },
                        campoEmail: {
                            required: "Digite o seu e-mail para contato",
                            email: "Digite um e-mail v&aacutelido"
                        },
                        campoSenha: {
                            required: "Digite sua senha",
                            minlength: "Sua senha deve conter, no m&iacutenimo, 6 caracteres"
                        },
                        campoRg: {
                            required: "Digite seu rg",
                            minlength: "O seu rg deve conter, no m&iacutenimo, 9 caracteres"
                        },
                        campoRua: {
                            required: "Digite sua rua",
                            minlength: "Sua rua deve conter, no m&iacutenimo, 5 caracteres"
                        },
                        campoNumero: {
                            required: "Digite o n&uacutemero",
                            minlength: "Seu n&uacutemero deve conter, no m&iacutenimo, 1 caracter"
                        },
                        campoComplemento: {
                            required: "Digite seu complemento",
                            minlength: "O seu complemento deve conter, no m&iacutenimo, 2 caracteres"
                        },
                        campoCidade: {
                            required: "Digite sua cidade",
                            minlength: "Sua cidade deve conter, no m&iacutenimo, 3 caracteres"
                        },
                        campoEstado: {
                            required: "Digite seu estado"

                        },
                        campoTelefone: {
                            required: "Digite seu telefone",
                            minlength: ""
                        },
                        campoCep: {
                            required: "Digite seu CEP",
                            minlength: ""
                        },
                        campoCpf: {
                            required: "Digite seu CPF",
                            minlength: ""
                        },
                        campoNascimento: {
                            required: "Digite sua data de nascimento",
                            minlength: ""
                        }

                    }
                });
            });

        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                //$("#campoNascimento").mask("99/99/9999");
                $("#campoCpf").mask("999.999.999-99");
                $("#campoCep").mask("99.999-999");
                $("#campoTelefone").mask("(99)9999-9999");
                $("#campoRg").mask("99.999.999-9");
            });
        </script>

        <script>
            $(function() {

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
    </head>
    <body>
<div id="main_container">

             <%@ include file="header.jsp"%>       

            <div id="main_content">
               
        
 <%@ include file="menu.jsp"%>       
 <%@ include file="menuEsquerda.jsp"%>    
 
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
                ?>

                <div class="center_content">
                    <div class="center_title_bar">
                        Nova conta
                    </div>

                    <div class="prod_box_big">

                        <div class="center_prod_box_big">

                            <div class="contact_form">
                                <form id="cliente" method="post" action="DAO/pessoaAction.php">

                                    <input type="hidden" name="acao" value="novaConta">

                                    <div class="form_row">
                                        <label class="contact"><strong>Nome completo:</strong></label>
                                        <input type="text" class="contact_input" name="campoNome" />
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Email:</strong></label>
                                        <input type="text" class="contact_input" name="campoEmail" />
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Senha:</strong></label>
                                        <input type="password" class="contact_input" name="campoSenha" />
                                    </div>


                                    <div class="form_row">
                                        <label class="contact"><strong>Telefone:</strong></label>
                                        <input type="text" id="campoTelefone" class="contact_input" name="campoTelefone"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>RG:</strong></label>
                                        <input type="text" id="campoRg" class="contact_input" name="campoRg" />
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>CPF:</strong></label>
                                        <input type="text" id="campoCpf" class="contact_input" name="campoCpf" />
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Data de nascimento:</strong></label>
                                        <input type="text" id="datepicker" class="contact_input" name="campoNascimento"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Rua:</strong></label>
                                        <input type="text" class="contact_input" name="campoRua"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Número:</strong></label>
                                        <input type="text" class="contact_input" name="campoNumero"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Complemento:</strong></label>
                                        <input type="text" class="contact_input" name="campoComplemento"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>CEP:</strong></label>
                                        <input type="text" id="campoCep" class="contact_input" name="campoCep"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Cidade:</strong></label>
                                        <input type="text" class="contact_input" name="campoCidade"/>
                                    </div>

                                    <div class="form_row">
                                        <label class="contact"><strong>Estado:</strong></label>  
                                        <select name="campoEstado" class="contact_input" >                                            
                                            <?php
                                            foreach ($estados as $key => $value) {

                                                echo "<option value='" . $key . "'>" . $value . "</option>";
                                            }
                                            ?>                                   
                                        </select>
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
