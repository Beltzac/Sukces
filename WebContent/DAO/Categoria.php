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
class Categoria {

    private $nome = null;
    private $cod = null;

    function set($campo, $valor) {
        $this->$campo = $valor;
    }

    function get($campo) {
        return $this->$campo;
    }

}

?>
