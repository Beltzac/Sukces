package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.dbutils.BeanProcessor;

import bean.UsuarioBean;

public class UsuarioDAO implements IDAO<UsuarioBean> {

	private Connection con;

	public UsuarioDAO() throws Exception {
		con = ConnectionFactory.getConnection();
	}

	@Override
	public UsuarioBean carregar(int id) throws Exception {
		PreparedStatement stmtCarregar;
		stmtCarregar = con.prepareStatement("SELECT * FROM usuario WHERE id = ?");
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
		PreparedStatement stmtLogin;
		stmtLogin = con.prepareStatement("SELECT * FROM usuario WHERE email = ? AND senha = MD5(?)");
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
		PreparedStatement stmtCarregarTodos;
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM usuario");
		ResultSet rs = stmtCarregarTodos.executeQuery();
		BeanProcessor bp = new BeanProcessor();
		List<UsuarioBean> l = bp.toBeanList(rs, UsuarioBean.class);
		rs.close();
		return l;
	}


	public List<UsuarioBean> pesquisar(String texto, List<String> campos)
			throws Exception {
		
		PreparedStatement stmtPesquisar;
		
		String sql = "SELECT * FROM usuario WHERE ";		

		for (String campo : campos) {
			sql += campo + " LIKE '%" + texto + "%'" + " OR ";
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
			PreparedStatement stmtGravar;
			System.out.println("Criando conta: " + obj.getEmail());
			stmtGravar = con.prepareStatement("INSERT INTO usuario (nome, email, senha, cpf, cnpj, cep, rua,cidade,estado, numero, telefone1, telefone2, administrador, data_criacao) VALUES (?,?,MD5(?),?,?,?,?,?,?,?,?,?,?,CURRENT_DATE())");
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
			PreparedStatement stmtAtualizar;
			System.out.println("Atualizando conta: " + obj.getEmail());
			stmtAtualizar = con.prepareStatement("UPDATE usuario SET nome = ?, email = ?, cpf = ?, cnpj = ?, cep = ?, rua = ?,cidade = ?,estado = ?, numero = ?, telefone1 = ?, telefone2 = ?, administrador = ? WHERE id = ?");
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
		PreparedStatement stmtDeletar;
		stmtDeletar = con.prepareStatement("DELETE FROM usuario WHERE id = ?");
		stmtDeletar.setInt(1, id);
		return stmtDeletar.executeUpdate();
	}
	
public int alterarSenha(UsuarioBean obj, String senhaNova, String senhaAntiga) throws Exception {
	
			PreparedStatement stmtAlterarSenha;	
			System.out.println("Atualizando senha: " + obj.getEmail());
			stmtAlterarSenha = con.prepareStatement("UPDATE usuario SET senha = MD5(?) WHERE id = ? AND senha = MD5(?)");
			stmtAlterarSenha.setString(1, senhaNova);
			stmtAlterarSenha.setInt(2, obj.getId());	
			stmtAlterarSenha.setString(3, senhaAntiga);
			return stmtAlterarSenha.executeUpdate();
	}

}
