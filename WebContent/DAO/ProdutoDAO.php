<?php
require_once 'connection.php';
require_once 'Produto.php';
require_once 'DAO.php';
class ProdutoDAO  extends DAO {
    function insert($produto) {
        $stmt = $this->con->stmt_init();

        $stmt->prepare("INSERT INTO PRODUTO (nome, descricao, estoque, peso, cod_marc, preco, categoria,dimensoes) VALUES (?,?,?,?,?,?,?,?)");
        if ($stmt) {
            $stmt->bind_param("ssiiisis", $produto->get('nome'), $produto->get('descricao'), $produto->get('estoque'), $produto->get('peso'), $produto->get('cod_marc'), $produto->get('preco'), $produto->get('categoria'),$produto->get('dimensoes'));
            
            $stmt->execute();
            $err = $stmt->errno;
              $stmt->close();
        }
           
            return $err;
        
    }

    function  selectAll($limite) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM produto LIMIT ?");
        $stmt->bind_param("i", $limite);
        $stmt->execute();
        $stmt->bind_result($nome, $descricao, $cod_prod,$categoria, $estoque, $peso, $cod_marc, $preco, $dimensoes);
        $result = array();
        while ($stmt->fetch()) {
            $p = new Produto();
            $p->set('nome', $nome);
            $p->set('descricao', $descricao);
            $p->set('cod_prod', $cod_prod);
            $p->set('estoque', $estoque);
            $p->set('peso', $peso);
            $p->set('cod_marc', $cod_marc);
            $p->set('preco', $preco);
            $p->set('dimensoes', $dimensoes);
            $p->set('categoria', $categoria);
            $result[] = $p;
        }
        $stmt->close();
        return $result;
    }     
    function  selectByCod($cod) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM produto WHERE cod_prod = ?");
        $stmt->bind_param("i", $cod);        
        $stmt->execute();
        echo $stmt->error;
        $stmt->bind_result($nome, $descricao, $cod_prod,$categoria, $estoque, $peso, $cod_marc, $preco, $dimensoes);

        while ($stmt->fetch()) {

            $p = new Produto();

            $p->set('nome', $nome);
            $p->set('descricao', $descricao);
            $p->set('cod_prod', $cod_prod);
            $p->set('estoque', $estoque);
            $p->set('peso', $peso);
            $p->set('cod_marc', $cod_marc);
            $p->set('preco', $preco);
            $p->set('dimensoes', $dimensoes);
            $p->set('categoria', $categoria);

        }
        
        $stmt->close();
        return $p;
    }

    function  selectLike($pesquisa,$limite = 50) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM produto WHERE concat_ws(' ',nome,descricao,preco,(select nome from categoria where cod = categoria),(select nome from marca where codmarc = cod_marc)) LIKE ? LIMIT ?");
        $param = "%".$pesquisa."%";
        $stmt->bind_param("si", $param,$limite);
        
        $stmt->execute();
        echo $stmt->error;
        $stmt->bind_result($nome, $descricao, $cod_prod,$categoria, $estoque, $peso, $cod_marc, $preco, $dimensoes);

        $result = array();



        while ($stmt->fetch()) {

            $p = new Produto();


            $p->set('nome', $nome);
            $p->set('descricao', $descricao);
            $p->set('cod_prod', $cod_prod);
            $p->set('estoque', $estoque);
            $p->set('peso', $peso);
            $p->set('cod_marc', $cod_marc);
            $p->set('preco', $preco);
            $p->set('dimensoes', $dimensoes);
            $p->set('categoria', $categoria);

            $result[] = $p;

        }


        $stmt->close();

        return $result;
    }
   
    
    function Update(Produto $produto) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("UPDATE PRODUTO set nome = ?, descricao = ?, estoque = ?, peso = ?, cod_marc = ?, preco = ?, categoria = ?,dimensoes = ? where cod_prod = ?");
        if ($stmt) {


            $stmt->bind_param("ssiiisisi", $produto->get('nome'), $produto->get('descricao'), $produto->get('estoque'), $produto->get('peso'), $produto->get('cod_marc'), $produto->get('preco'), $produto->get('categoria'),$produto->get('dimensoes'),$produto->get('cod_prod'));

            $stmt->execute();
            $err = $stmt->errno;
            $stmt->close();           
        }
         return $err;
    }
    
    function Delete($cod) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("DELETE FROM PRODUTO where cod_prod = ?");
        
        
        if ($stmt) {


           $stmt->bind_param("i", $cod);

            $stmt->execute();
            echo $stmt->error;
            $err = $stmt->errno;
            $stmt->close();           
        }
         return $err;
    }
    
}

?>
