<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of carrinhoDAO
 *
 * @author Codification
 */

require_once 'connection.php';
require_once 'DAO.php';
require_once 'Produto.php';
class carrinhoDAO extends DAO {
    
     function  total($pedido) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("select sum(total), count(total) from (SELECT (quantidade * preco) as total FROM contem WHERE cod_ped = ?) as total");
        $stmt->bind_param("i", $pedido);
        
        $stmt->execute();
        echo $stmt->error;
        
        $stmt->bind_result($total,$count);

        while ($stmt->fetch()) {      
            $p = array($total,$count);
        }
        
        $stmt->close();
        return $p;
    }
    



function  selectProdutosPedido($pedido) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT nome, descricao,pro.cod_prod,categoria, estoque, peso, cod_marc, pro.preco,dimensoes, quantidade FROM produto pro, contem c where c.cod_ped = ? and pro.cod_prod = c.cod_prod");
         $stmt->bind_param("i", $pedido);
        $stmt->execute();
        echo $stmt->error;
        $stmt->bind_result($nome, $descricao, $cod_prod,$categoria, $estoque, $peso, $cod_marc, $preco, $dimensoes,$quantidade);

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

            $result[] = array($p, $quantidade);

        }


        $stmt->close();

        return $result;
    }
}
?>
