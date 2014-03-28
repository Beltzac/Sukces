<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of DAO_Pedido
 *
 * @author Codification
 */
require_once 'connection.php';
require_once 'Pedido.php';
require_once 'DAO.php';


class PedidoDAO extends DAO {

     function insert($pedido) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("INSERT INTO Pedido (situacao,forma_d_entreg, forma_d_pag,id_p,cod_end) VALUES (?,?,?,?,?)");
        if ($stmt) {


            $stmt->bind_param("sssii", $pedido->get('situacao'), $pedido->get('forma_d_entreg'), $pedido->get('forma_d_pag'), $pedido->get('id_p'), $pedido->get('cod_end'));
            
            $stmt->execute();
            $err = $stmt->errno;
              $stmt->close();
        }
           
            return $err;
        
    }

    function  selectAll($limite = 1000) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM produto LIMIT ?");
         $stmt->bind_param("i", $limite);
        $stmt->execute();
        $stmt->bind_result($situacao,$cod_pedido,$forma_d_entreg, $forma_d_pag,$data,$id_p,$cod_end);

        $result = array();



        while ($stmt->fetch()) {

            $p = new Pedido();

            $p->set('situacao', $situacao);
            $p->set('cod_pedido', $cod_pedido);
            $p->set('forma_d_entreg', $forma_d_entreg);
            $p->set('forma_d_pag', $forma_d_pag);
            $p->set('data', $data);
            $p->set('id_p', $id_p);
            $p->set('cod_end', $cod_end);          

            $result[] = $p;

        }


        $stmt->close();

        return $result;
    }
    
    
    function  selectByCod($cod) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM pedido WHERE cod_pedido = ? LIMIT 1");
        $stmt->bind_param("i", $cod);
        
        $stmt->execute();

        $stmt->bind_result($situacao,$cod_pedido,$forma_d_entreg, $forma_d_pag,$data,$id_p,$cod_end);

        while ($stmt->fetch()) {

            $p = new Pedido();

            $p->set('situacao', $situacao);
            $p->set('cod_pedido', $cod_pedido);
            $p->set('forma_d_entreg', $forma_d_entreg);
            $p->set('forma_d_pag', $forma_d_pag);
            $p->set('data', $data);
            $p->set('id_p', $id_p);
            $p->set('cod_end', $cod_end);

        }
        
        $stmt->close();
        return $p;
    }
    
    
        function  selectAtual($codPessoa) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM pedido WHERE id_p = ? and situacao = ? ORDER BY cod_pedido DESC LIMIT 1");
        $param = 'carrinho';
        $stmt->bind_param("is", $codPessoa, $param );
        
        $stmt->execute();
        echo $stmt->error;
        $stmt->bind_result($situacao,$cod_pedido,$forma_d_entreg, $forma_d_pag,$data,$id_p,$cod_end);

        $p=null;
        while ($stmt->fetch()) {

            $p = new Pedido();

            $p->set('situacao', $situacao);
            $p->set('cod_pedido', $cod_pedido);
            $p->set('forma_d_entreg', $forma_d_entreg);
            $p->set('forma_d_pag', $forma_d_pag);
            $p->set('data', $data);
            $p->set('id_p', $id_p);
            $p->set('cod_end', $cod_end);

        }
        echo $stmt->error;
        $stmt->close();
        return $p;
    }

    
    function  selectAllPessoa($codPessoa) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM pedido WHERE id_p = ? and situacao <> 'carrinho' ORDER BY cod_pedido DESC");        
        $stmt->bind_param("i", $codPessoa );
        
        $stmt->execute();
        echo $stmt->error;
        $stmt->bind_result($situacao,$cod_pedido,$forma_d_entreg, $forma_d_pag,$data,$id_p,$cod_end);
        $result = array();
        $p=null;
        while ($stmt->fetch()) {

            $p = new Pedido();

            $p->set('situacao', $situacao);
            $p->set('cod_pedido', $cod_pedido);
            $p->set('forma_d_entreg', $forma_d_entreg);
            $p->set('forma_d_pag', $forma_d_pag);
            $p->set('data', $data);
            $p->set('id_p', $id_p);
            $p->set('cod_end', $cod_end);
            $result[] = $p;

        }
        echo $stmt->error;
        $stmt->close();
        return $result;
    }
    
    function Update(Pedido $pedido) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("UPDATE PEDIDO set situacao = ?,forma_d_entreg = ?, forma_d_pag = ?,id_p = ?,cod_end = ? where cod_pedido = ?");
        if ($stmt) {         
            $stmt->bind_param("sssiii", $pedido->get('situacao'), $pedido->get('forma_d_entreg'), $pedido->get('forma_d_pag'), $pedido->get('id_p'), $pedido->get('cod_end'), $pedido->get('cod_pedido'));
            
            $stmt->execute();
            echo $stmt->error;
            $err = $stmt->errno;
            $stmt->close();           
        }
         return $err;
    }
    
    function Delete($cod) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("DELETE FROM pedido where cod_pedido = ?");
        
        
        if ($stmt) {


           $stmt->bind_param("i", $cod);

            $stmt->execute();
            $err = $stmt->errno;
            $stmt->close();           
        }
         return $err;
    }
    
}
    


?>
