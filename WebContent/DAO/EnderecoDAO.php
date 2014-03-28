<?php
require_once 'connection.php';
require_once 'Endereco.php';
require_once 'DAO.php';
class EnderecoDAO extends DAO {
    function insert(Endereco $endereco) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("INSERT INTO endereco (rua, num, complemento, cidade, estado, cep) VALUES (?,?,?,?,?,?)");
        if ($stmt) {
            $stmt->bind_param("sissss", $endereco->get('rua'), $endereco->get('num'), $endereco->get('complemento'), $endereco->get('cidade'), $endereco->get('estado'), $endereco->get('cep'));

            $stmt->execute();
            
           // echo $stmt->error;
            
            $err = $stmt->errno;
            $stmt->close();

            return $err;
        }
    }

    function  selectAll() {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM endereco");

        $stmt->execute();

        $stmt->bind_result($rua, $num, $complemento, $cidade, $estado, $cep,$cod_end);

        $result = array();



        while ($stmt->fetch()) {

            $p = new Endereco();


            $p->set('rua', $rua);
            $p->set('num', $num);
            $p->set('complemento', $complemento);
            $p->set('cidade', $cidade);
            $p->set('estado', $estado);
            $p->set('cep', $cep);
            $p->set('cod_end', $cod_end);

            $result[] = $p;

        }


        $stmt->close();

        return $result;
    }
    
    
    function  selectByCod($cod) {
                $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM endereco where cod_end = ?");
        $stmt->bind_param("i", $cod);

        $stmt->execute();

        $stmt->bind_result($rua, $num, $complemento, $cidade, $estado, $cep,$cod_end);



        while ($stmt->fetch()) {

            $p = new Endereco();


            $p->set('rua', $rua);
            $p->set('num', $num);
            $p->set('complemento', $complemento);
            $p->set('cidade', $cidade);
            $p->set('estado', $estado);
            $p->set('cep', $cep);
            $p->set('cod_end', $cod_end);

           

        }


        $stmt->close();

        return $p;
    }

    
     function Delete($cod) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("DELETE FROM endereco where cod_end = ?");
        
        
        if ($stmt) {


           $stmt->bind_param("i", $cod);

            $stmt->execute();
            $err = $stmt->errno;
            $stmt->close();           
        }
         return $err;
    }
    
        function update(Endereco $endereco) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("update endereco set rua = ?, num = ?, complemento = ?, cidade = ?, estado = ?, cep = ? where cod_end = ?");
        if ($stmt) {


            $stmt->bind_param("sissssi", $endereco->get('rua'), $endereco->get('num'), $endereco->get('complemento'), $endereco->get('cidade'), $endereco->get('estado'), $endereco->get('cep'),$endereco->get('cod_end'));

            $stmt->execute();
            
            echo $stmt->error;
            
            $err = $stmt->errno;
            $stmt->close();

            return $err;
        }
    }
    
}

?>
