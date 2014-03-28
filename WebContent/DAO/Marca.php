<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of marca
 *
 * @author Codification
 */
class Marca {

    private $nome = null;
    private $codmarc = null;

    function set($campo, $valor) {
        $this->$campo = $valor;
    }

    function get($campo) {
        return $this->$campo;
    }

}

?>
