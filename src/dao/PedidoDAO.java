package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.dbutils.BeanProcessor;

import com.mysql.jdbc.Statement;

import bean.ItemPedidoBean;
import bean.PedidoBean;

public class PedidoDAO implements IDAO<PedidoBean> {

	private Connection con;

	public PedidoDAO() throws Exception {
		con = ConnectionFactory.getConnection();
	}

	@Override
	public PedidoBean carregar(int id) throws Exception {
		PreparedStatement stmtCarregar;
		stmtCarregar = con.prepareStatement("SELECT * FROM pedido WHERE id = ?");
		stmtCarregar.setInt(1, id);
		ResultSet rs = stmtCarregar.executeQuery();
		PedidoBean o = null;

		if (rs.next()) {
			BeanProcessor bp = new BeanProcessor();
			o = bp.toBean(rs, PedidoBean.class);
		}
		
		o.setItems(carregarTodosItems(o.getId()));

		rs.close();
		return o;
	}
	
	public List<ItemPedidoBean> carregarTodosItems(int idPedido) throws Exception {
		PreparedStatement stmtCarregarTodos;
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM itemPedido WHERE pedido = ?");
		stmtCarregarTodos.setInt(1, idPedido);
		ResultSet rs = stmtCarregarTodos.executeQuery();
		BeanProcessor bp = new BeanProcessor();
		List<ItemPedidoBean> l = bp.toBeanList(rs, ItemPedidoBean.class);
		rs.close();
		return l;
	}
	


	
	public List<PedidoBean> carregarTodos(int idusuario) throws Exception {
		PreparedStatement stmtCarregarTodos;
		stmtCarregarTodos = con.prepareStatement("SELECT * FROM pedido WHERE usuario = ?");
		stmtCarregarTodos.setInt(1, idusuario);
		ResultSet rs = stmtCarregarTodos.executeQuery();
		BeanProcessor bp = new BeanProcessor();
		List<PedidoBean> l = bp.toBeanList(rs, PedidoBean.class);
		
		for (PedidoBean pedidoBean : l) {
			pedidoBean.setItems(carregarTodosItems(pedidoBean.getId()));
		}
		
		rs.close();
		return l;
	}




	@Override
	public void gravar(PedidoBean obj, boolean update) throws Exception {
		
		
		if (!update){
			PreparedStatement stmtGravar;			
			stmtGravar = con.prepareStatement("INSERT INTO pedido (usuario, status, transactionCode) VALUES (?,?,?)",Statement.RETURN_GENERATED_KEYS);
			stmtGravar.setInt(1, obj.getUsuario());
			stmtGravar.setString(2, "AGUARDANDO_APROVACAO");
			stmtGravar.setString(3, obj.getTransactionCode());		
			
			stmtGravar.executeUpdate();
			ResultSet rs = 	stmtGravar.getGeneratedKeys();
			int id = 0;
			if (rs.next()){
			   id = rs.getInt(1);
			}
			
			for (ItemPedidoBean item : obj.getItems()) {
				PreparedStatement stmtGravarItem;			
				stmtGravarItem = con.prepareStatement("INSERT INTO itemPedido (valor, quantidade, pedido, produto, imagem, comentarios) VALUES(?,?,?,?,?,?)");
				stmtGravarItem.setDouble(1, item.getValor());
				stmtGravarItem.setInt(2, item.getQuantidade());
				stmtGravarItem.setInt(3, id);
				stmtGravarItem.setInt(4, item.getProduto());
				stmtGravarItem.setString(5, item.getImagem());
				stmtGravarItem.setString(6, item.getComentarios());		
				
				stmtGravarItem.executeUpdate();
			}
			
		} else {
			PreparedStatement stmtAtualizar;			
			stmtAtualizar = con.prepareStatement("UPDATE pedido SET usuario = ?, status = ?, transactionCode = ? WHERE id = ?");
			stmtAtualizar.setInt(1, obj.getUsuario());
			stmtAtualizar.setString(2, obj.getStatus());
			stmtAtualizar.setString(3, obj.getTransactionCode());			
			stmtAtualizar.setInt(4, obj.getId());
			
			stmtAtualizar.executeUpdate();					
			
		}

	}

	@Override
	public int deletar(int id) throws Exception {
		PreparedStatement stmtDeletar;
		stmtDeletar = con.prepareStatement("DELETE FROM pedido WHERE id = ?");
		stmtDeletar.setInt(1, id);
		return stmtDeletar.executeUpdate();
	}

	@Override
	public List<PedidoBean> carregarTodos() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

}
