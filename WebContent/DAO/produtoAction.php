<?php

include '../session_start.php';
if (!$_SESSION['admin']) {
    header('Location: ../index.php');
    exit();
}

if (!isset($_POST['tipo'])) {
    redirect();
    exit();
}

require_once 'ProdutoDAO.php';

function redirect() {
    if (isset($_SERVER['HTTP_REFERER'])) {
        header("Location:" . $_SERVER['HTTP_REFERER']);
    } else {
        header('Location: ../index.php');
    }
}



$dao = new ProdutoDAO();

switch ($_POST['tipo']) {
    case 'Novo':

        $p = new Produto();
        
        $p->set("nome", $_POST["nome"]);
        $p->set("descricao", $_POST["descricao"]);
        $p->set("estoque", $_POST["estoque"]);
        $p->set("peso", $_POST["peso"]);
        $p->set("cod_marc", $_POST["cod_marc"]);
        $p->set("preco", $_POST["preco"]);
        $p->set('categoria', $_POST["categoria"]);
        $p->set('dimensoes', $_POST["dimensoes"]);



        $err = $dao->insert($p);

        if (!$err) {



            move_uploaded_file($_FILES['imagem']['tmp_name'], "../imagensProdutos/" . $dao->lastID() . ".jpg");

            redirect();
        } else {

            echo 'Erro!';
        }
        break;

    case 'Atualizar':

        $p = new Produto();
        $p->set("nome", $_POST["nome"]);
        $p->set("descricao", $_POST["descricao"]);
        $p->set("estoque", $_POST["estoque"]);
        $p->set("peso", $_POST["peso"]);
        $p->set("cod_marc", $_POST["cod_marc"]);
        $p->set("preco", $_POST["preco"]);
        $p->set('categoria', $_POST["categoria"]);
        $p->set('dimensoes', $_POST["dimensoes"]);
        $p->set("cod_prod", $_POST["codigo"]);


        $err = $dao->Update($p);

        if (!$err) {
            move_uploaded_file($_FILES['imagem']['tmp_name'], "../imagensProdutos/" . $_POST["codigo"] . ".jpg");
            redirect();
        } else {
            echo 'Erro!';
        }
    
        break;

    case 'Deletar':

        $err = $dao->Delete($_POST["codigo"]);
        if (!$err) {
            unlink("../imagensProdutos/" . $_POST["codigo"] . ".jpg");            
            header('Location: ../admin.php');            
        } else {
            echo 'Erro!';
        }

        break;

    default:
        break;
}
redirect()
?>
