<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>

        <?php
        require_once 'DAO/relatorioDAO.php';
        date_default_timezone_set('America/Sao_Paulo');
        $opcao = $_POST['op'];
        $str = $_POST['cod_marc'];
        $data1 = $_POST['datepicker2'];
        $data2 = $_POST['thedate'];
        $cod = (int) $str;
        list($dt_d1, $dt_m1, $dt_y1) = explode('/', $data1);
        list($dt_d2, $dt_m2, $dt_y2) = explode('/', $data2);
        $dt1 = mktime(0, 0, 0, $dt_m1, $dt_d1, $dt_y1);
        $dt2 = mktime(0, 0, 0, $dt_m2, $dt_d2, $dt_y2);
        if ($dt1 > $dt2)
            die("A data de 'até' é menor que a de 'de'");
        if ($opcao == "op1") {
            echo 'Relatório de clientes mais fiéis, de ' . $data1 . ' a ' . $data2;
            echo '<table border = "1">';
            $dao = new relatorioDAO();
            $lista = $dao->selectByCiente($data1, $data2);
            foreach ($lista as $value) {
                echo "<tr><td>Nome da pessoa:</td><td>" . $value->get('nome_pessoa') . "</td></tr>";
                echo "<tr><td>id:</td><td>" . $value->get('id') . "</td></tr>";
                echo "<tr><td>arrecadacao:</td><td>R$" . $value->get('arrecadacao') . "</td></tr>";
            }
            echo '</table>';
        }
        if ($opcao == "op2") {
            echo 'Relatório de vendas por marca, de ' . $data1 . ' a ' . $data2;
            echo '<table border = "1">';
            $dao2 = new relatorioDAO();
            $lista2 = $dao2->selectByMarca($cod, $data1, $data2); //$data1, $data2);
            foreach ($lista2 as $key) {
                echo "<tr><td>nome_produto:</td><td>" . $key->get('nome') . "</td></tr>";
                echo "<tr><td>preco:</td><td>R$" . $key->get('preco') . "</td></tr>";
                echo "<tr><td>quantidade vendida</td><td>" . $key->get('quant_vend') . "</td></tr>";
                echo "<tr><td>arrecadação</td><td>R$" . $key->get('arrecadacao') . "</td></tr>";
            }
            echo '</table>';
        }
        if ($opcao == "op3") {
            echo 'Relatório de vendas, de ' . $data1 . ' a ' . $data2;
            echo '<table border = "1">';
            $dao2 = new relatorioDAO();
            $lista2 = $dao2->selectByvenda($data1, $data2);
            foreach ($lista2 as $key) {
                echo "<tr><td>nome_produto:</td><td>" . $key->get('nome') . "</td></tr>";
                echo "<tr><td>preco:</td><td>R$" . $key->get('preco') . "</td></tr>";
                echo "<tr><td>quantidade vendida</td><td>" . $key->get('quant_vend') . "</td></tr>";
                echo "<tr><td>arrecadação</td><td>R$" . $key->get('arrecadacao') . "</td></tr>";
                echo "<tr><td>marca: </td><td>" . $key->get('marca') . "</td></tr>";
            }
            echo '</table>';
        }
        ?>  
    </body>
</html>