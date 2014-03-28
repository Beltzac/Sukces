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

require_once 'MarcaDAO.php';

function redirect() {
    if (isset($_SERVER['HTTP_REFERER'])) {
        header("Location:" . $_SERVER['HTTP_REFERER']);
    } else {
        header('Location: ../index.php');
    }
}



$dao = new MarcaDAO();

switch ($_POST['tipo']) {
    case 'Novo':

        $p = new Marca();
        $p->set("nome", $_POST["nome"]);
        $p->set("codmarc", $_POST["codmarc"]);

        $err = $dao->insert($p);

    case 'Atualizar':

        $p = new Marca();
        $p->set("nome", $_POST["nome"]);
        $p->set("codmarc", $_POST["codmarc"]);
   


        $err = $dao->Update($p);


        break;

    case 'Deletar':

         $dao->Delete($_POST["codmarc"]);
    

        break;

    default:
        break;
}
redirect()
?>
