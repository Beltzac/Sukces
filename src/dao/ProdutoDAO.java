package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.dbutils.BeanProcessor;

import bean.ProdutoBean;

import com.mysql.jdbc.Statement;

public class ProdutoDAO implements IDAO<ProdutoBean> {

	private Connection con;

	private PreparedStatement stmtCarregar;
	private PreparedStatement stmtCarregarTodos;
	private PreparedStatement stmtPesquisar;	
	private PreparedStatement stmtGravar;
	private PreparedStatement stmtAtualizar;
	private PreparedStatement stmtDeletar;

	public ProdutoDAO() throws Exception {
		con = ConnectionFactory.getConnection();	
	}

	@Override
	public ProdutoBean carregar(int id) throws Exception {
		stmtCarregar = con.prepareStatement("SELECT * FROM produto WHERE id = ?");
		stmtCarregar.setInt(1, id);
		ResultSet rs = stmtCarregar.executeQuery();
		ProdutoBean o = null;

		if (rs.next()) {
			BeanProcessor bp = new BeanProcessor();
			o = bp.toBean(rs, ProdutoBean.class);
		}

		rs.close();
		return o;
	}
	

	@Override
	public List<ProdutoBean> carregarTodos() throws Exception {
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM produto");
		ResultSet rs = stmtCarregarTodos.executeQuery();
		BeanProcessor bp = new BeanProcessor();
		List<ProdutoBean> l = bp.toBeanList(rs, ProdutoBean.class);
		rs.close();
		return l;
	}

	@Override
	public List<ProdutoBean> pesquisar(String texto,  List<String> campos)
			throws Exception {

		String sql;

		sql = "SELECT * FROM produto WHERE ";

		for (String campo : campos) {
			sql += campo + " LIKE '%" + texto + "%'" + " OR ";
		}

		// Remove último AND
		sql = sql.substring(0, sql.length() - 4);

		stmtPesquisar = con.prepareStatement(sql);
		ResultSet rs = stmtPesquisar.executeQuery();

		BeanProcessor bp = new BeanProcessor();
		List<ProdutoBean> l = bp.toBeanList(rs, ProdutoBean.class);
		rs.close();
		return l;
	}

	@Override
	public void gravar(ProdutoBean obj, boolean update) throws Exception {
		
		stmtGravar = con.prepareStatement("INSERT INTO produto (nome, categoria, preco, descricao, extencao, data_criacao) VALUES (?,?,?,?,?,CURRENT_DATE())",Statement.RETURN_GENERATED_KEYS);
		stmtAtualizar = con.prepareStatement("UPDATE produto SET nome = ?, categoria = ?, preco = ?, descricao = ?, extencao = ? WHERE id = ?");
		
		
		if (!update){
			System.out.println("Criando produto: " + obj.toString());
			
			stmtGravar.setString(1, obj.getNome());
			stmtGravar.setInt(2, obj.getCategoria());
			stmtGravar.setDouble(3, obj.getPreco());
			stmtGravar.setString(4, obj.getDescricao());
			stmtGravar.setString(5, obj.getExtencao());			
			
			stmtGravar.executeUpdate();
			
			ResultSet rs = 	stmtGravar.getGeneratedKeys();
			if (rs.next()){
			    obj.setId(rs.getInt(1));
			}
			
			
		} else {
			System.out.println("Atualizando produto: " + obj.toString());
			
			stmtAtualizar.setString(1, obj.getNome());
			stmtAtualizar.setInt(2, obj.getCategoria());
			stmtAtualizar.setDouble(3, obj.getPreco());
			stmtAtualizar.setString(4, obj.getDescricao());
			stmtAtualizar.setString(5, obj.getExtencao());			
			stmtAtualizar.setInt(6, obj.getId());
			
			stmtAtualizar.executeUpdate();					
			
		}

	}
	
public void atualizarSemImagem(ProdutoBean obj) throws Exception {		
		
		stmtAtualizar = con.prepareStatement("UPDATE produto SET nome = ?, categoria = ?, preco = ?, descricao = ?, extencao = ? WHERE id = ?");
				

			System.out.println("Atualizando produto: " + obj.toString());
			
			stmtAtualizar.setString(1, obj.getNome());
			stmtAtualizar.setInt(2, obj.getCategoria());
			stmtAtualizar.setDouble(3, obj.getPreco());
			stmtAtualizar.setString(5, obj.getDescricao());					
			stmtAtualizar.setInt(6, obj.getId());
			
			stmtAtualizar.executeUpdate();					
			
		

	}


	@Override
	public int deletar(int id) throws Exception {
		stmtDeletar = con.prepareStatement("DELETE FROM produto WHERE id = ?");
		stmtDeletar.setInt(1, id);
		return stmtDeletar.executeUpdate();
	}

}
