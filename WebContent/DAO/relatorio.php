<?php

class Relatorio {

    private $nome = null;
    private $nome_pessoa = null;
    private $descricao = null;
    private $cod_prod = null;
    private $estoque = null;
    private $peso = null;
    private $cod_marc = null;
    private $preco = null;
    private $categoria = null;
    private $dimensoes = null;
    private $quant_vend = null;
    private $arrecadacao = null;
    private $data = null;
    private $id = null;
    private $marca = null;

//private $quant = null;

    function set($campo, $valor) {
        $this->$campo = $valor;
    }

    function get($campo) {
        return $this->$campo;
    }

}

?>
