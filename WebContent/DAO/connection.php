<?php
class connection{
private static $connection = NULL;
function conecta() {	
	$conexao = new mysqli("127.0.0.1", "root", "","lolwtf2") or die("Problem connecting: ".mysqli_error());        
	return $conexao;
}
public static function getInstance() {
 if (self::$connection == NULL) 
 {
     self::$connection = new Connection();
 }  
   return self::$connection;   
 }
}
?>