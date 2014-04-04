<div class="right_content">

    <div class="title_box">
        Pesquisa
    </div>
    <div class="border_box">
        <form action="pesquisa.jsp" method="get">
            <input type="text" name="pesquisa" class="newsletter_input" value=""/>
            <input class="submit" type="submit" value="Pesquisar" name="tipo"/>
        </form>
    </div>

    <%

     if (loginBean.isAutenticado()) {
/*
        if (!isset($_SESSION['quantidadeProdutos']) || !isset($_SESSION['valorTotal'])) {

            $caDAO = new carrinhoDAO();
            $total = $caDAO->total($_SESSION['carrinho']);
            $_SESSION['valorTotal'] = $total[0];
            $_SESSION['quantidadeProdutos'] = $total[1];
        }
*/
        %>

        <div class="shopping_cart">
            <div class="title_box">
                Carrinho
            </div>

            <div class="cart_details">
                <?php echo $_SESSION['quantidadeProdutos'] ?> item(s)
                <br />
                <span class="border_cart"></span>
                Total: <span class="price">R$ <?php echo $_SESSION['valorTotal'] ?></span>
            </div>

            <div class="cart_icon">
                <a href="carrinho.jsp" title=""><img src="images/shoppingcart.png" alt="" title="" width="35" height="35" border="0" /></a>
            </div>

        </div>

    <% } else { %>

        <div class="login">
            <div class="title_box">
                Login
            </div>

            <form id="login" method="post" action="action/login_manager.jsp">
                E-mail:
                <input type="text" name="email" class="login_input" value=""/>
                Senha:
                <input type="password" name="senha" class="login_input" value=""/>
                <input class="join" type="submit" value="Login" />


            </form>
        </div>

    <%} %>

    <div class="title_box">
        Novidades
    </div>
    <div class="border_box">
        <div class="product_title">
            <a href="details.jsp?cod=<?php echo $codigo; ?>"><?php echo $nome; ?></a>
        </div>
        <div class="product_img">
            <a href="details.jsp?cod=<?php echo $codigo; ?>"><img src="<?php echo $imagem; ?>" alt="" title="" border="0" height = "100"/></a>
        </div>
        <div class="prod_price">
            <span class="price">R$ <?php echo $preco; ?></span>
        </div>
    </div>

   

    <div class="banner_adds">


    </div>

</div><!-- menu direita -->
