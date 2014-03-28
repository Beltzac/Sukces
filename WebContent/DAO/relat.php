<?php
class relat {
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
