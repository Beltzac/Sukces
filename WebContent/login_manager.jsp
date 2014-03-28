<!--  <?php

include 'session_start.php';
require_once 'DAO/PessoaDAO.php';
require_once 'DAO/PedidoDAO.php';

function redirect() {
    if (isset($_SERVER['HTTP_REFERER'])) {
        header("Location:" . $_SERVER['HTTP_REFERER']);
    } else {
        header('Location: index.php');
    }
}

if (isset($_GET['logout'])) {
    session_destroy();
    redirect();
    exit();
}

if (!isset($_POST['email']) || !isset($_POST['senha'])) {
    redirect();
    exit();
}

$email = $_POST['email'];
$senha = $_POST['senha'];

$pdao = new PessoaDAO();
$pedidodao = new PedidoDAO();

$p = $pdao->selectByEmail($email, $senha);


if ($p != null) {
    //inicializa dados da sessão
    $_SESSION['logado'] = TRUE;
    $_SESSION['id'] = $p->get('id');
    $_SESSION['nome'] = $p->get('nome');
    $_SESSION['cod_end'] = $p->get('cod_end');

    if ($p->get('nivel_d_aces') > 0) {
        $_SESSION['admin'] = TRUE;
    } else {
        $_SESSION['admin'] = FALSE;
    }

    $carrinho = $pedidodao->selectAtual($_SESSION['id']);
    if ($carrinho != null) {
        $_SESSION['carrinho'] = $carrinho->get('cod_pedido');
    } else {
        header('Location: dao/carrinhoAction.php?tipo=iniciar');
        exit();
    }

    redirect();
} else {

    // senha incorreta
    session_destroy();
    header('Location: novaconta.php');
}
?>

-->

<%

if(request.getParameter("logout") != null){
	if(session!=null){
		session.invalidate();	
		response.sendRedirect("index.jsp");
	}
}else{
	String email = request.getParameter("email");
	String senha = request.getParameter("senha");
	
	//buscar usuario

	if ((email.equals("ale") && senha.equals("123"))) {
		session.setAttribute("logado", true);
		session.setAttribute("administrador", true);
		response.sendRedirect("index.jsp");
	} else
		response.sendRedirect("novaconta.jsp");
}
%>


