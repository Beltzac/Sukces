<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of DAO_Produto
 *
 * @author Codification
 */
require_once 'connection.php';
require_once 'Categoria.php';
require_once 'DAO.php';

class CategoriaDAO  extends DAO {

 

 

    function insert(Categoria $categoria) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("INSERT INTO categoria (nome) VALUES (?)");
        if ($stmt) {


            $stmt->bind_param("s", $categoria->get('nome'));

            $stmt->execute();
            $err = $stmt->errno;
            $stmt->close();

            return $err;
        }
    }

    function  selectAll() {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM categoria");

        $stmt->execute();

        $stmt->bind_result($codmarc, $nome);

        $result = array();



        while ($stmt->fetch()) {

            $p = new Categoria();


            $p->set('nome', $nome);
            $p->set('cod', $codmarc);
       

            $result[] = $p;

        }


        $stmt->close();

        return $result;
    }
    
    
    function  selectByCod($cod) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM categoria WHERE cod = ?");
$stmt->bind_param("i", $cod);
        
        $stmt->execute();

         $stmt->bind_result($codmarc, $nome);

       



        while ($stmt->fetch()) {

            $p = new Categoria();


            $p->set('nome', $nome);
            $p->set('cod', $codmarc);
       

            $result[] = $p;

        }


        $stmt->close();

        return $p;
    }

    
   
    
}

?>
