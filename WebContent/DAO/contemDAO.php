<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of contemDAO
 *
 * @author Codification
 */

require_once 'connection.php';
require_once 'contem.php';
require_once 'DAO.php';

class contemDAO extends DAO {
function insert($contem) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("INSERT INTO contem (quantidade,preco, cod_prod,cod_ped) VALUES (?,?,?,?)");
        if ($stmt) {


            $stmt->bind_param("iiii", $contem->get('quantidade'), $contem->get('preco'), $contem->get('cod_prod'), $contem->get('cod_ped'));
            
            $stmt->execute();
            $err = $stmt->errno;
            echo $stmt->error;
              $stmt->close();
        }
           
            return $err;
        
    }

    function  selectAll() {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM contem");
        $stmt->execute();
        $stmt->bind_result($quantidade,$preco, $cod_prod,$cod_ped);

        $result = array();



        while ($stmt->fetch()) {

            $p = new contem();


            $p->set('quantidade', $quantidade);
            $p->set('preco', $preco);
            $p->set('cod_prod', $cod_prod);
            $p->set('cod_ped', $cod_ped);
          
          

            $result[] = $p;

        }


        $stmt->close();

        return $result;
    }
    
    
    function  selectByCod($cod_ped, $cod_prod) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM contem WHERE cod_ped = ? and cod_prod = ?");
        $stmt->bind_param("ii", $cod_ped, $cod_prod);
        
        $stmt->execute();

          $stmt->bind_result($quantidade,$preco, $cod_prod,$cod_ped);

        while ($stmt->fetch()) {

            $p = new contem();


            $p->set('quantidade', $quantidade);
            $p->set('preco', $preco);
            $p->set('cod_prod', $cod_prod);
            $p->set('cod_ped', $cod_ped);
          
          

            $result = $p;

        }


        $stmt->close();

        return $result;
    }
    
    
        function  selectAllByCod($cod_ped) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM contem WHERE cod_ped = ?");
        $stmt->bind_param("i", $cod_ped);
        
        $stmt->execute();

        $stmt->bind_result($quantidade,$preco, $cod_prod,$cod_ped);

        $result = array();
   
        while ($stmt->fetch()) {

            $p = new contem();

            $p->set('quantidade', $quantidade);
            $p->set('preco', $preco);
            $p->set('cod_prod', $cod_prod);
            $p->set('cod_ped', $cod_ped);       
          
            $result[] = $p;

        }

        echo $stmt->error;
        $stmt->close();

        return $result;
    }
   
    
    function Update(contem $contem) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("UPDATE contem set quantidade = ?,preco = ? where cod_prod = ? and cod_ped = ?");
        if ($stmt) {


            $stmt->bind_param("iiii", $contem->get('quantidade'), $contem->get('preco'), $contem->get('cod_prod'), $contem->get('cod_ped'));

            $stmt->execute();
            echo $stmt->error;
            $err = $stmt->errno;
            $stmt->close();           
        }
         return $err;
    }
    
    
    function Delete($cod_prod, $cod_ped) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("DELETE FROM contem where cod_prod = ? and cod_ped = ?");
        
        
        if ($stmt) {


           $stmt->bind_param("ii", $cod_prod,$cod_ped);
           echo $stmt->error;

            $stmt->execute();
            $err = $stmt->errno;
            $stmt->close();           
        }
         return $err;
    }
    
}
    


?>
