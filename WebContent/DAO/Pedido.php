<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Pedido
 *
 * @author Codification
 */


class Pedido  {
        
    private $situacao = null;
    private $cod_pedido = null;
    private $forma_d_entreg = null;
    private $forma_d_pag = null;
    private $data = null;
    private $id_p = null;
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
