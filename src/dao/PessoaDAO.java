package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.dbutils.BeanProcessor;

import bean.PessoaBean;

public class PessoaDAO implements IDAO<PessoaBean> {

	private Connection con;

	private PreparedStatement stmtCarregar;
	private PreparedStatement stmtCarregarTodos;
	private PreparedStatement stmtPesquisar;
	private PreparedStatement stmtGravar;
	private PreparedStatement stmtDeletar;

	public PessoaDAO() throws Exception {
		con = ConnectionFactory.getConnection();

		stmtGravar = con
				.prepareStatement("INSERT INTO usuario (nome, email, senha, cpf, cnpj, cep, rua,cidade,estado, numero, telefone1, telefone2, administrador, data_criacao) VALUES (?,?,MD5(?),?,?,?,?,?,?,?,?,?,?,CURRENT_DATE())");
		stmtCarregar = con
				.prepareStatement("SELECT * FROM usuario WHERE id = ?");
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM usuario");
		stmtDeletar = con.prepareStatement("DELETE FROM usuario WHERE id = ?");

	}

	@Override
	public PessoaBean carregar(int id) throws Exception {
		stmtCarregar.setInt(1, id);
		ResultSet rs = stmtCarregar.executeQuery();
		PessoaBean o = null;

		if (rs.next()) {
			BeanProcessor bp = new BeanProcessor();
			o = bp.toBean(rs, PessoaBean.class);
		}

		rs.close();
		return o;
	}

	@Override
	public List<PessoaBean> carregarTodos() throws Exception {
		ResultSet rs = stmtCarregarTodos.executeQuery();
		BeanProcessor bp = new BeanProcessor();
		List<PessoaBean> l = bp.toBeanList(rs, PessoaBean.class);
		rs.close();
		return l;
	}

	@Override
	public List<PessoaBean> pesquisar(String texto, String[] campos)
			throws Exception {

		String sql;

		sql = "SELECT * FROM usuario WHERE ";

		for (String campo : campos) {
			sql += campo + " LIKE %" + texto + "%" + " AND ";
		}

		// Remove último AND
		sql = sql.substring(0, sql.length() - 4);

		stmtPesquisar = con.prepareStatement(sql);
		ResultSet rs = stmtPesquisar.executeQuery();

		BeanProcessor bp = new BeanProcessor();
		List<PessoaBean> l = bp.toBeanList(rs, PessoaBean.class);
		rs.close();
		return l;
	}

	@Override
	public void gravar(PessoaBean obj) throws Exception {
		
		if (obj.getId() == -1){
			System.out.println("Criando conta: " + obj.getEmail());
			
			stmtGravar.setString(1, obj.getNome());
			stmtGravar.setString(2, obj.getEmail());
			stmtGravar.setString(3, obj.getSenha());
			stmtGravar.setString(4, obj.getCpf());
			stmtGravar.setString(5, obj.getCnpj());
			stmtGravar.setString(6, obj.getCep());
			stmtGravar.setString(7, obj.getRua());
			stmtGravar.setString(8, obj.getCidade());
			stmtGravar.setString(9, obj.getEstado());
			stmtGravar.setInt(10, obj.getNumero());
			stmtGravar.setString(11, obj.getTelefone1());
			stmtGravar.setString(12, obj.getTelefone2());
			stmtGravar.setBoolean(13, obj.isAdministrador());					
			stmtGravar.executeUpdate();
			
		} else {
			System.out.println("Atualizando conta: " + obj.getEmail());
			
			
			
		}

	}

	@Override
	public int deletar(int id) throws Exception {
		stmtDeletar.setInt(1, id);
		return stmtDeletar.executeUpdate();
	}

}
