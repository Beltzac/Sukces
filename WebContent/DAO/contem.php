<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of contem
 *
 * @author Codification
 */
class contem {

    private $quantidade = null;
    private $preco = null;
    private $cod_prod = null;
    private $cod_ped = null;
    //private $data = null;

       function set($campo, $valor) {
        $this->$campo = $valor;
    }

    function get($campo) {
        return $this->$campo;
    }
}

?>
