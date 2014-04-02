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
				.prepareStatement("INSERT INTO usuario (nome, email, senha, cpf, cnpj, cep, endereco, numero, telefone1, telefone2, administrador, data_criacao) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
		stmtCarregar = con
				.prepareStatement("SELECT * FROM usuario WHERE id = ?");
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM usuario");
		stmtDeletar = con.prepareStatement("DELETE FROM usuario WHERE id = ?");

	}

	@Override
	public PessoaBean carregar(int id) throws Exception {
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
		// TODO Auto-generated method stub

	}

	@Override
	public int deletar(int id) throws Exception {
		stmtDeletar.setInt(0, id);
		return stmtDeletar.executeUpdate();
	}

}
