<jsp:useBean id="usuario" scope="session" class="bean.PessoaBean"/>

<!--  <?php
if (isset($_SESSION['logado']) && $_SESSION['logado']) {
    require_once 'DAO/PedidoDAO.php';
    if (!isset($_SESSION['carrinho']) || $_SESSION['carrinho'] == NULL) {

        $pedidodao = new PedidoDAO();
        $carrinho = $pedidodao->selectAtual($_SESSION['id']);
        if ($carrinho != null) {
            $_SESSION['carrinho'] = $carrinho->get('cod_pedido');
        } else {
            header('Location: dao/carrinhoAction.php?tipo=iniciar&goto=../index.php');
        }
    }
}
?> -->
<div id="header">

    <div class="top_right">

        <div class="big_banner">
            <a href="#"><img src="images/banner728.jpg" alt="" title="" border="0" /></a>
        </div>

    </div>

    <div id="logo">
        <a href="index.jsp"><img src="images/logo.png" alt="" title="" border="0" width="182" height="85" /></a>
    </div>

</div>

