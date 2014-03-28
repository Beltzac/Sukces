<?php
if (!isset($_GET['cod'])) {
    header('Location: index.php');
    exit();
}

include 'session_start.php';
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Detalhes - Lolwtf Mobile</title>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <!--[if IE 6]>
        <link rel="stylesheet" type="text/css" href="iecss.css" />
        <![endif]-->
        <script type="text/javascript" src="js/boxOver.js"></script>
        <script src="js/jquery-2.0.2.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="jquery-ui.min.css" />
        <script>
            PositionX = 100;
            PositionY = 100;

            defaultWidth = 500;
            defaultHeight = 500;
            var AutoClose = true;

            if (parseInt(navigator.appVersion.charAt(0)) >= 4) {
                var isNN = (navigator.appName == "Netscape") ? 1 : 0;
                var isIE = (navigator.appName.indexOf("Microsoft") != -1) ? 1 : 0;
            }
            var optNN = 'scrollbars=no,width=' + defaultWidth + ',height=' + defaultHeight + ',left=' + PositionX + ',top=' + PositionY;
            var optIE = 'scrollbars=no,width=150,height=100,left=' + PositionX + ',top=' + PositionY;
            function popImage(imageURL, imageTitle) {
                if (isNN) {
                    imgWin = window.open('about:blank', '', optNN);
                }
                if (isIE) {
                    imgWin = window.open('about:blank', '', optIE);
                }
                with (imgWin.document) {
                    writeln('<html><head><title>Loading...</title><style>body{margin:0px;}</style>');
                    writeln('<sc' + 'ript>');
                    writeln('var isNN,isIE;');
                    writeln('if (parseInt(navigator.appVersion.charAt(0))>=4){');
                    writeln('isNN=(navigator.appName=="Netscape")?1:0;');
                    writeln('isIE=(navigator.appName.indexOf("Microsoft")!=-1)?1:0;}');
                    writeln('function reSizeToImage(){');
                    writeln('if (isIE){');
                    writeln('window.resizeTo(300,300);');
                    writeln('width=300-(document.body.clientWidth-document.images[0].width);');
                    writeln('height=300-(document.body.clientHeight-document.images[0].height);');
                    writeln('window.resizeTo(width,height);}');
                    writeln('if (isNN){');
                    writeln('window.innerWidth=document.images["George"].width;');
                    writeln('window.innerHeight=document.images["George"].height;}}');
                    writeln('function doTitle(){document.title="' + imageTitle + '";}');
                    writeln('</sc' + 'ript>');
                    if (!AutoClose)
                        writeln('</head><body bgcolor=ffffff scroll="no" onload="reSizeToImage();doTitle();self.focus()">')
                    else
                        writeln('</head><body bgcolor=ffffff scroll="no" onload="reSizeToImage();doTitle();self.focus()" onblur="self.close()">');
                    writeln('<img name="George" src=' + imageURL + ' style="display:block"></body></html>');
                    close();
                }
            }
            $(function() {
                $("#spinner").spinner({
                    step: 1,
                    numberFormat: "n",
                    min: 1,
                    max: 20
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
 
                require_once 'funcoes.php';

                require_once 'DAO/ProdutoDAO.php';


                $cod = $_GET['cod'];

                $pdao = new ProdutoDAO();

                $p = $pdao->selectByCod($cod);


                $nome = $p->get('nome');
                $preco = $p->get('preco');

                $imagem = imagem($cod);

                $descricao = $p->get('descricao');
                ?>

                <div class="center_content">

                    <div class="center_title_bar">
                        <?php echo $nome; ?>
                    </div>

                    <div class="prod_box_big">

                        <div class="center_prod_box_big">

                            <div class="product_img_big">
                                <a href="javascript:popImage('<?php echo str_replace('\\', '/', $imagem) ?>','<?php echo $nome; ?>')" title="header=[Zoom] body=[&nbsp;] fade=[on]"><img src="<?php echo $imagem; ?>" alt="" title="" border="0" width ="180" /></a>
                                <div class="thumbs">
                                    <a href="#" title="header=[Thumb1] body=[&nbsp;] fade=[on]"><img src="<?php echo $imagem; ?>" alt="" title="" border="0" height ="40"/></a>
                                    <a href="#" title="header=[Thumb2] body=[&nbsp;] fade=[on]"><img src="<?php echo $imagem; ?>" alt="" title="" border="0" height ="40"/></a>
                                    <a href="#" title="header=[Thumb3] body=[&nbsp;] fade=[on]"><img src="<?php echo $imagem; ?>" alt="" title="" border="0" height ="40"/></a>
                                </div>
                            </div>
                            <div class="details_big_box">
                                <div class="product_title_big">
                                    <?php echo $nome; ?>
                                </div>
                                <div class="specifications">
                                    Disponibilidade: <span class="blue">Imediata</span>
                                    <br />

                                    Garantia: <span class="blue">24 meses</span>
                                    <br />

                                    Peso(g): <span class="blue"> 200g</span>
                                    <br />

                                    Dimensões :<span class="blue"> 10x50x200</span>
                                    <br />
                                    Descrição :<span class="blue"> <?php echo $descricao; ?></span>
                                    <br />
                                </div>
                                <div class="prod_price_big">
                                    <span class="price">R$<?php echo $preco; ?></span>
                                </div>

                                <form action="dao/carrinhoAction.php" method="get">
                                    <div class="prod_price2">
                                        <p>                         
                                            <input id="spinner" name="quantidade" value="1" />
                                        </p>
                                    </div>
                                    <input type="hidden" name="tipo" value="adicionarProduto">
                                        <input type="hidden" name="cod_prod" value="<?php echo $cod ?>">
                                            <input type="submit" id="but" style="display:none;">                                      
                                                <a href="#" onclick="document.getElementById('but').click();" class="prod_buy">Comprar</a>
                                                </form>

                                                <?php
                                                if (isset($_SESSION['admin']) && $_SESSION['admin']) {

                                                    echo '<a href = admin.php?action=produto&cod=' . $p->get('cod_prod') . ' class="prod_buy" style="color:red">Modificar</a>';
                                                }
                                                ?>

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
