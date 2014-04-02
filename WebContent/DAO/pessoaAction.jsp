<!--  <?php
session_start();
require_once 'PessoaDAO.php';
require_once 'enderecoDAO.php';

function redirect() {
    if (isset($_SERVER['HTTP_REFERER'])) {
        header("Location:" . $_SERVER['HTTP_REFERER']);
    } else {
        header('Location: index.php');
    }
}

$data_nasc=$_POST['campoNascimento'];
if(!$data_nasc){
    $data_nasc=$_POST['nascimento'];
}
//converteData($data_nasc,'/','-');
$data_nasc = implode('-',array_reverse(explode('/',$data_nasc)));
//echo $data_nasc;
$data_nasc=date('Y-m-d',strtotime($data_nasc));
echo $data_nasc;

$edao = new EnderecoDAO();
$pdao = new PessoaDAO();
switch ($_POST['acao']) {
    case 'novaConta':

        $e = new Endereco;

        $e->set('rua', $_POST['campoRua']);
        $e->set('cep', $_POST['campoCep']);
        $e->set('cidade', $_POST['campoCidade']);
        $e->set('estado', $_POST['campoEstado']);
        $e->set('num', $_POST['campoNumero']);
        $e->set('complemento', $_POST['campoComplemento']);

        $err = $edao->insert($e);


        if (!$err) {


            $last = $edao->lastID();


            $p = new Pessoa();

            $p->set('nome', $_POST['campoNome']);
            $p->set('telefone', $_POST['campoTelefone']);
            $p->set('email', $_POST['campoEmail']);
            $p->set('rg', $_POST['campoRg']);
            $p->set('cpf', $_POST['campoCpf']);
            $p->set('nivel_d_aces', 0);
            $p->set('senha', '000000');
            $p->set('cod_end', $last);
            $p->set('nascimento', $data_nasc);
            
           $err = $pdao->insert($p);           

            if(strlen($_POST['campoSenha']) >= 6  && !$err){
            $last = $pdao->lastID();
            $pdao->updateSenha($last, $_POST['campoSenha']);            
        }
        
        }
        header('Location: index.php');
        exit();
        break;

    case 'Atualizar':

        $e = new Endereco;

        $e->set('rua', $_POST['rua']);
        $e->set('cep', $_POST['cep']);
        $e->set('cidade', $_POST['cidade']);
        $e->set('estado', $_POST['estado']);
        $e->set('num', $_POST['num']);
        $e->set('complemento', $_POST['complemento']);
        $e->set('cod_end', $_POST['cod_end']);

        $edao->update($e);

        $p = new Pessoa();

        $p->set('nome', $_POST['nome']);
        $p->set('telefone', $_POST['telefone']);
        $p->set('email', $_POST['email']);
        $p->set('rg', $_POST['rg']);
        $p->set('cpf', $_POST['cpf']);        
        $p->set('nascimento', $data_nasc);
        $p->set('cod_end', $_POST['cod_end']);
        $p->set('id', $_POST['id']);


        $pdao->update($p);
        $pdao ->updateNivel($_POST['id'], $_POST['nivel_d_aces']);
        if(strlen($_POST['senha']) >= 6){
            $pdao->updateSenha($_POST['id'], $_POST['senha']);            
        }

        break;

    case 'AtualizarPessoa':


        $p = new Pessoa();

        $p->set('nome', $_POST['nome']);
        $p->set('telefone', $_POST['telefone']);
        $p->set('email', $_POST['email']);
        $p->set('rg', $_POST['rg']);
        $p->set('cpf', $_POST['cpf']);
        $p->set('nascimento', $data_nasc);
        $p->set('cod_end', $_POST['cod_end']);
        $p->set('id', $_POST['id']);


        $pdao->update($p);
        
        if(strlen($_POST['senha']) >= 6){
            $pdao->updateSenha($_SESSION['id'], $_POST['senha']);            
        }

        break;

    case 'AtualizarEndereco':

        $e = new Endereco;

        $e->set('rua', $_POST['rua']);
        $e->set('cep', $_POST['cep']);
        $e->set('cidade', $_POST['cidade']);
        $e->set('estado', $_POST['estado']);
        $e->set('num', $_POST['num']);
        $e->set('complemento', $_POST['complemento']);
        $e->set('cod_end', $_POST['cod_end']);

        $edao->update($e);



        break;

    case 'Deletar':

        $pdao->Delete($_POST['id']);
        $edao->Delete($_POST['cod_end']);

        break;

    default:
        break;
}

redirect();
?> -->

<%@page import="dao.PessoaDAO"%>

<jsp:useBean id="cliente" scope="request" class="bean.PessoaBean" />
<jsp:setProperty property="*" name="cliente" />

<%
	PessoaDAO dao = new PessoaDAO();

	switch ((String) session.getAttribute("acao")) {

	case "novo":
		dao.gravar(cliente);
		break;

	}
%>