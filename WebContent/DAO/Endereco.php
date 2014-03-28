<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of endereco
 *
 * @author Codification
 */
class Endereco {
   
   private $rua = null;
   private $num = null;
   private $complemento = null;
   private $cidade= null;
   private $estado= null;
   private $cep= null;
   private $cod_end = null;
   
   function set($campo, $valor)
{
$this->$campo = $valor;
}

function get($campo)
{
return $this->$campo;
}

    
}

?>
