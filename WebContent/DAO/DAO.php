<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of DAO
 *
 * @author Codification
 */
class DAO {
    protected  $con = null;

    function __construct() {

        $cf = connection::getInstance();
        $this->con = $cf->conecta();

        //TODO Testar por erros
    }
    
       function  lastID() {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT LAST_INSERT_ID()");

        $stmt->execute();

        $stmt->bind_result($id);     


        while ($stmt->fetch()) {

            $ret = $id;

        }


        $stmt->close();

        return $ret;
    }
}

?>
