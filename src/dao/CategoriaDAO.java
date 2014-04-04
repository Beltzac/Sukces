package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.dbutils.BeanProcessor;

import bean.CategoriaBean;

public class CategoriaDAO implements IDAO<CategoriaBean> {

	private Connection con;

	private PreparedStatement stmtCarregar;
	private PreparedStatement stmtCarregarTodos;
	private PreparedStatement stmtGravar;
	private PreparedStatement stmtAtualizar;
	private PreparedStatement stmtDeletar;

	public CategoriaDAO() throws Exception {
		con = ConnectionFactory.getConnection();

		stmtGravar = con
				.prepareStatement("INSERT INTO categoria (nome) VALUES (?)");
		
		stmtAtualizar = con
				.prepareStatement("UPDATE categoria SET nome = ? WHERE id = ?");		
		
		stmtCarregar = con.prepareStatement("SELECT * FROM categoria WHERE id = ?");		
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM categoria");
		stmtDeletar = con.prepareStatement("DELETE FROM categoria WHERE id = ?");

	}

	@Override
	public CategoriaBean carregar(int id) throws Exception {
		stmtCarregar.setInt(1, id);
		ResultSet rs = stmtCarregar.executeQuery();
		CategoriaBean o = null;

		if (rs.next()) {
			BeanProcessor bp = new BeanProcessor();
			o = bp.toBean(rs, CategoriaBean.class);
		}

		rs.close();
		return o;
	}
	

	@Override
	public List<CategoriaBean> carregarTodos() throws Exception {
		ResultSet rs = stmtCarregarTodos.executeQuery();
		BeanProcessor bp = new BeanProcessor();
		List<CategoriaBean> l = bp.toBeanList(rs, CategoriaBean.class);
		rs.close();
		return l;
	}

	@Override
	public void gravar(CategoriaBean obj, boolean update) throws Exception {
		
		System.out.println("Gravando categoria: " + obj.toString());
		
		if (!update){
			
			
			stmtGravar.setString(1, obj.getNome());		
			
			stmtGravar.executeUpdate();
			
		} else {			
			
			stmtAtualizar.setString(1, obj.getNome());
			stmtAtualizar.setInt(2, obj.getId());
			
			stmtAtualizar.executeUpdate();					
			
		}

	}

	@Override
	public int deletar(int id) throws Exception {
		stmtDeletar.setInt(1, id);
		return stmtDeletar.executeUpdate();
	}

	@Override
	public List<CategoriaBean> pesquisar(String texto, String[] campos)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}