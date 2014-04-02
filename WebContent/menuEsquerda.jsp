<!--
<?php
require_once 'funcoes.php';
require_once 'DAO/ProdutoDAO.php';
require_once 'DAO/CategoriaDAO.php';
//include_once 'php_fast_cache.php';

//$p = phpFastCache::get("produtoEsquerdo");

/*if (!$p) {
    $pdao = new ProdutoDAO();
    $p = $pdao->selectByCod(33);
    phpFastCache::set("produtoEsquerdo", $p, 600);
}*/

$pdao = new ProdutoDAO();
    $p = $pdao->selectByCod(33);

$nome = $p->get('nome');
$preco = $p->get('preco');
$codigo = $p->get('cod_prod');
$imagem = imagem($p->get('cod_prod'));
?>
-->
<div class="left_content">
    <div class="title_box">
        Categorias
    </div>

    <ul class="left_menu">
    <!--
        <?php
        /*$categorias = phpFastCache::get("categorias");

        if (!$categorias) {
            $cdao = new CategoriaDAO();
            $categorias = $cdao->selectAll();
            phpFastCache::set("categorias", $categorias, 600);
        }*/
		    $cdao = new CategoriaDAO();
            $categorias = $cdao->selectAll();
        $i = 0;
        foreach ($categorias as $value) {

            if ($i % 2 == 0) {
                echo '<li class="odd">';
            } else {
                echo '<li class="even">';
            }
            echo '<a href="pesquisa.php?pesquisa=' . $value->get('nome') . '">' . $value->get('nome') . '</a></li>';
            $i++;
        }
        ?>
        -->
    </ul>

    <div class="title_box">
        Promoção!
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

        <a href="#"><img src="images/bann2.jpg" alt="" title="" border="0" /></a>
    </div>

</div><!-- menu esquerda -->
