<?php

require_once 'DAO.PHP';
require_once 'connection.php';
require_once 'marca.php';
require_once 'pessoaDAO.php';
require_once 'produtoDAO.php';
require_once 'contem.php';
require_once 'relatorio.php';

class relatorioDAO extends DAO {

    function selectByCiente($data1, $data2) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT pedido.data, pessoa.nome, pessoa.id, SUM(contem.quantidade * contem.preco)
            AS total FROM pessoa, contem, pedido WHERE contem.cod_ped = pedido.cod_pedido 
            AND pedido.id_p = pessoa.id GROUP BY pessoa.id ORDER BY total DESC");
        $stmt->execute();
        echo $stmt->error;
        $stmt->bind_result($tempo, $nome, $pessoa, $total);
        $result = array();
        while ($stmt->fetch()) {
            list($dt_d1, $dt_m1, $dt_y1) = explode('/', $data1);
            list($dt_d2, $dt_m2, $dt_y2) = explode('/', $data2);
            $data1final = date("Y-m-d" . " H:i:s", mktime(0, 0, 0, $dt_m1, $dt_d1, $dt_y1));
            $data2final = date("Y-m-d" . " H:i:s", mktime(0, 0, 0, $dt_m2, $dt_d2, $dt_y2));
            if (($tempo >= $data1final) && ($data2final >= $tempo)) {
                $p = new Relatorio();
                $p->set('nome_pessoa', $nome);
                $p->set('arrecadacao', $total);
                $p->set('id', $pessoa);
                $result[] = $p;
            }
        }
        $stmt->close();
        return $result;
    }

    function selectByMarca($cod, $data1, $data2) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT pedido.data, produto.nome, SUM(contem.quantidade) AS quant, 
            SUM(contem.quantidade * contem.preco) AS total, contem.preco FROM  marca, produto, 
            contem, pedido  WHERE contem.cod_ped = pedido.cod_pedido and contem.cod_prod = produto.cod_prod AND produto.cod_marc = marca.codmarc 
            AND marca.codmarc = ? GROUP BY produto.nome ORDER BY total DESC");
        $stmt->bind_param('i', $cod);
        $stmt->execute();
        echo $stmt->error;
        $result = array();
        $stmt->bind_result($tempo, $produtonome, $quant_vend, $total, $produtopreco); // string, string, string, integer
        while ($stmt->fetch()) {
            list($dt_d1, $dt_m1, $dt_y1) = explode('/', $data1);
            list($dt_d2, $dt_m2, $dt_y2) = explode('/', $data2);
            $data1final = date("Y-m-d" . " H:i:s", mktime(0, 0, 0, $dt_m1, $dt_d1, $dt_y1));
            $data2final = date("Y-m-d" . " H:i:s", mktime(0, 0, 0, $dt_m2, $dt_d2, $dt_y2));
            if (($tempo >= $data1final) && ($data2final >= $tempo)) {
                $p = new Produto();
                $p->set('data', $tempo);
                $p->set('nome', $produtonome);
                $p->set('quant_vend', $quant_vend);
                $p->set('arrecadacao', $total);
                $p->set('preco', $produtopreco);
                $result[] = $p;
            }
        }
        $stmt->close();
        if ($result == null)
            die("</br>nenhum produto foi vendido deste fabricante");
        return $result;
    }

    function selectByvenda($data1, $data2) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT pedido.data, produto.nome, SUM(contem.quantidade) AS quant, 
            SUM(contem.quantidade * contem.preco) AS total, contem.preco, marca.nome FROM  marca, produto, 
            contem,pedido  WHERE contem.cod_ped = pedido.cod_pedido and contem.cod_prod = produto.cod_prod AND produto.cod_marc = marca.codmarc 
            GROUP BY produto.nome ORDER BY total DESC");
        $stmt->execute();
        echo $stmt->error;
        $result = array();
        $stmt->bind_result($tempo, $produtonome, $quant_vend, $total, $produtopreco, $marca); // string, string, string, integer
        while ($stmt->fetch()) {
            list($dt_d1, $dt_m1, $dt_y1) = explode('/', $data1);
            list($dt_d2, $dt_m2, $dt_y2) = explode('/', $data2);
            $data1final = date("Y-m-d" . " H:i:s", mktime(0, 0, 0, $dt_m1, $dt_d1, $dt_y1));
            $data2final = date("Y-m-d" . " H:i:s", mktime(0, 0, 0, $dt_m2, $dt_d2, $dt_y2));
            if (($tempo >= $data1final) && ($data2final >= $tempo)) {
                $p = new Relatorio();
                $p->set('nome', $produtonome);
                $p->set('quant_vend', $quant_vend);
                $p->set('arrecadacao', $total);
                $p->set('preco', $produtopreco);
                $p->set('marca', $marca);
                $result[] = $p;
            }
        }
        $stmt->close();
        if ($result == null)
            die("</br>nenhum produto foi vendido");
        return $result;
    }

}

?>
