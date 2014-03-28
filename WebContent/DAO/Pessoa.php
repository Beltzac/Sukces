<?php

class Pessoa {
    
    private $nome = null;
    private $telefone = null;
    private $senha = null;
    private $email = null;
    private $rg = null;
    private $cpf = null;
    private $nivel_d_aces = null;
    private $cod_end = null;
    private $id = null;
    private $nascimento = null;

    function set($campo, $valor) {
        $this->$campo = $valor;
    }

    function get($campo) {
        return $this->$campo;
    }

}

?>
