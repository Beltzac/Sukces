package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.dbutils.BeanProcessor;

import bean.UsuarioBean;

public class UsuarioDAO implements IDAO<UsuarioBean> {

	private Connection con;

	private PreparedStatement stmtCarregar;
	private PreparedStatement stmtCarregarTodos;
	private PreparedStatement stmtPesquisar;
	private PreparedStatement stmtLogin;
	private PreparedStatement stmtGravar;
	private PreparedStatement stmtAtualizar;
	private PreparedStatement stmtDeletar;

	public UsuarioDAO() throws Exception {
		con = ConnectionFactory.getConnection();

		stmtGravar = con
				.prepareStatement("INSERT INTO usuario (nome, email, senha, cpf, cnpj, cep, rua,cidade,estado, numero, telefone1, telefone2, administrador, data_criacao) VALUES (?,?,MD5(?),?,?,?,?,?,?,?,?,?,?,CURRENT_DATE())");
		
		stmtAtualizar = con
				.prepareStatement("UPDATE usuario SET nome = ?, email = ?, cpf = ?, cnpj = ?, cep = ?, rua = ?,cidade = ?,estado = ?, numero = ?, telefone1 = ?, telefone2 = ?, administrador = ? WHERE id = ?");
		
		
		
		stmtCarregar = con.prepareStatement("SELECT * FROM usuario WHERE id = ?");
		stmtLogin = con.prepareStatement("SELECT * FROM usuario WHERE email = ? AND senha = MD5(?)");
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM usuario");
		stmtDeletar = con.prepareStatement("DELETE FROM usuario WHERE id = ?");

	}

	@Override
	public UsuarioBean carregar(int id) throws Exception {
		stmtCarregar.setInt(1, id);
		ResultSet rs = stmtCarregar.executeQuery();
		UsuarioBean o = null;

		if (rs.next()) {
			BeanProcessor bp = new BeanProcessor();
			o = bp.toBean(rs, UsuarioBean.class);
		}

		rs.close();
		return o;
	}
	
	public UsuarioBean carregar(String email, String senha) throws Exception{
		stmtLogin.setString(1, email);
		stmtLogin.setString(2, senha);
		ResultSet rs = stmtLogin.executeQuery();
		UsuarioBean o = null;

		if (rs.next()) {
			BeanProcessor bp = new BeanProcessor();
			o = bp.toBean(rs, UsuarioBean.class);
		}

		rs.close();
		return o;
		
	}

	@Override
	public List<UsuarioBean> carregarTodos() throws Exception {
		ResultSet rs = stmtCarregarTodos.executeQuery();
		BeanProcessor bp = new BeanProcessor();
		List<UsuarioBean> l = bp.toBeanList(rs, UsuarioBean.class);
		rs.close();
		return l;
	}

	@Override
	public List<UsuarioBean> pesquisar(String texto, String[] campos)
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
		List<UsuarioBean> l = bp.toBeanList(rs, UsuarioBean.class);
		rs.close();
		return l;
	}

	@Override
	public void gravar(UsuarioBean obj, boolean update) throws Exception {
		
		if (!update){
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
			stmtGravar.setString(10, obj.getNumero());
			stmtGravar.setString(11, obj.getTelefone1());
			stmtGravar.setString(12, obj.getTelefone2());
			stmtGravar.setBoolean(13, obj.isAdministrador());	
			
			stmtGravar.executeUpdate();
			
		} else {
			System.out.println("Atualizando conta: " + obj.getEmail());
			
			stmtAtualizar.setString(1, obj.getNome());
			stmtAtualizar.setString(2, obj.getEmail());			
			stmtAtualizar.setString(3, obj.getCpf());
			stmtAtualizar.setString(4, obj.getCnpj());
			stmtAtualizar.setString(5, obj.getCep());
			stmtAtualizar.setString(6, obj.getRua());
			stmtAtualizar.setString(7, obj.getCidade());
			stmtAtualizar.setString(8, obj.getEstado());
			stmtAtualizar.setString(9, obj.getNumero());
			stmtAtualizar.setString(10, obj.getTelefone1());
			stmtAtualizar.setString(11, obj.getTelefone2());
			stmtAtualizar.setBoolean(12, obj.isAdministrador());
			stmtAtualizar.setInt(13, obj.getId());
			
			stmtAtualizar.executeUpdate();					
			
		}

	}

	@Override
	public int deletar(int id) throws Exception {
		stmtDeletar.setInt(1, id);
		return stmtDeletar.executeUpdate();
	}

}
