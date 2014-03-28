<?php

require_once 'connection.php';
require_once 'Pessoa.php';
require_once 'DAO.php';

function converteData($data, $se, $ss){
    return implode($ss, array_reverse(explode($se, $data)));
}


class PessoaDAO extends DAO {
    function insert(Pessoa $pessoa) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("INSERT INTO pessoa (nome, telefone, senha, email, rg, cpf, nivel_d_aces, cod_end, nascimento) VALUES (?,?,md5(?),?,?,?,?,?,?)");
        if ($stmt) {
            $stmt->bind_param("sssssssss", $pessoa->get('nome'), $pessoa->get('telefone'), $pessoa->get('senha'), $pessoa->get('email'), $pessoa->get('rg'), $pessoa->get('cpf'), $pessoa->get('nivel_d_aces'), $pessoa->get('cod_end'), $pessoa->get('nascimento'));
            $stmt->execute();
            $err = $stmt->errno;
            $stmt->close();

            return $err;
        }
    }


    
    function selectAll() {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM pessoa");

        $stmt->execute();

        $stmt->bind_result($nome, $telefone, $senha, $email, $rg, $cpf, $nivel_d_aces, $cod_end, $id, $nascimento);

        $result = array();


        while ($stmt->fetch()) {

            $p = new Pessoa();


            $p->set('nome', $nome);
            $p->set('telefone', $telefone);
            $p->set('senha', $senha);
            $p->set('email', $email);
            $p->set('rg', $rg);
            $p->set('cpf', $cpf);
            $p->set('nivel_d_aces', $nivel_d_aces);
            $p->set('cod_end', $cod_end);
            $p->set('id', $id);
            $p->set('nascimento', converteData($nascimento, '-', '/'));

            $result[] = $p;
        }


        $stmt->close();

        return $result;
    }

     function selectLike($pesquisa,$limite = 50) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM pessoa p WHERE concat_ws(' ',nome,telefone,email,rg,cpf,nivel_d_aces,id ,(select rua from endereco e where e.cod_end = p.cod_end)) LIKE ? LIMIT ?");
        $param = "%".$pesquisa."%";
        $stmt->bind_param("si", $param,$limite);
        $stmt->execute();
        echo $stmt->error;
        $stmt->bind_result($nome, $telefone, $senha, $email, $rg, $cpf, $nivel_d_aces, $cod_end, $id, $nascimento);

        $result = array();


        while ($stmt->fetch()) {

            $p = new Pessoa();


            $p->set('nome', $nome);
            $p->set('telefone', $telefone);
            $p->set('senha', $senha);
            $p->set('email', $email);
            $p->set('rg', $rg);
            $p->set('cpf', $cpf);
            $p->set('nivel_d_aces', $nivel_d_aces);
            $p->set('cod_end', $cod_end);
            $p->set('id', $id);
            $p->set('nascimento',$nascimento);

            $result[] = $p;
        }


        $stmt->close();

        return $result;
    }
    
    function selectByCod($cod) {
        $stmt = $this->con->stmt_init();
        $stmt->prepare("SELECT * FROM pessoa where id = ?");
        $stmt->bind_param("i", $cod);

        $stmt->execute();

        $stmt->bind_result($nome, $telefone, $senha, $email, $rg, $cpf, $nivel_d_aces, $cod_end, $id, $nascimento);




        while ($stmt->fetch()) {

            $p = new Pessoa();


            $p->set('nome', $nome);
            $p->set('telefone', $telefone);
            $p->set('senha', $senha);
            $p->set('email', $email);
            $p->set('rg', $rg);
            $p->set('cpf', $cpf);
            $p->set('nivel_d_aces', $nivel_d_aces);
            $p->set('cod_end', $cod_end);
            $p->set('id', $id);
            $p->set('nascimento', converteData($nascimento, '-', '/'));
        }


        $stmt->close();

        return $p;
    }

    function selectByEmail($email, $senha) {
        $stmt = $this->con->stmt_init();

        $stmt->prepare("SELECT * FROM pessoa where email = ? and senha = md5(?)");
        $stmt->bind_param("ss", $email, $senha);

        $stmt->execute();

        $stmt->bind_result($nome, $telefone, $senha, $email, $rg, $cpf, $nivel_d_aces, $cod_end, $id, $nascimento);

     


        $p = null;
        while ($stmt->fetch()) {

            $p = new Pessoa();


            $p->set('nome', $nome);
            $p->set('telefone', $telefone);
            $p->set('senha', $senha);
            $p->set('email', $email);
            $p->set('rg', $rg);
            $p->set('cpf', $cpf);
            $p->set('nivel_d_aces', $nivel_d_aces);
            $p->set('cod_end', $cod_end);
            $p->set('id', $id);
            $p->set('nascimento', converteData($nascimento, '-', '/'));

            
        }


        $stmt->close();

        return $p;
    }

    function Delete($cod) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("DELETE FROM pessoa where id = ?");


        if ($stmt) {


            $stmt->bind_param("i", $cod);

            $stmt->execute();
            $err = $stmt->errno;
            $stmt->close();
        }
        return $err;
    }

    function update(Pessoa $pessoa) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("update pessoa set nome = ?, telefone = ?, email = ?, rg = ?, cpf = ?, cod_end = ?, nascimento = ? where id = ?");
        if ($stmt) {


            $stmt->bind_param("ssssssss", $pessoa->get('nome'), $pessoa->get('telefone'), $pessoa->get('email'), $pessoa->get('rg'), $pessoa->get('cpf'), $pessoa->get('cod_end'), $pessoa->get('nascimento'), $pessoa->get('id'));

            $stmt->execute();
            echo $stmt->error;
            $err = $stmt->errno;
            $stmt->close();

            return $err;
        }
    }

    function updateSenha($id, $senha) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("update pessoa set senha = md5(?) where id = ?");
        if ($stmt) {


            $stmt->bind_param("si", $senha, $id);

            $stmt->execute();
            echo $stmt->error;
            $err = $stmt->errno;
            $stmt->close();

            return $err;
        }
    }
    
    function updateNivel($id, $nivel) {


        $stmt = $this->con->stmt_init();

        $stmt->prepare("update pessoa set nive_d_aces = ? where id = ?");
        if ($stmt) {


            $stmt->bind_param("is", $nivel, $id);

            $stmt->execute();
            echo $stmt->error;
            $err = $stmt->errno;
            $stmt->close();

            return $err;
        }
    }

}
