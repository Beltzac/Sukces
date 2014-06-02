package bean;

import java.io.Serializable;
import java.util.List;

public class PedidoBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int usuario;
	private int id;
	private String status;
	private String transactionCode;
	private List<ItemPedidoBean> items;
	
	public double getTotal(){
		double total = 0;
		if(items != null)
		for(ItemPedidoBean entry : items) {
		    total += entry.getTotal();
		}		
		return total;
	}
	
	@Override
	public String toString() {
		return "pedidoBean [usuario=" + usuario + ", id=" + id + ", status="
				+ status + ", transactionCode=" + transactionCode + "]";
	}
	public int getUsuario() {
		return usuario;
	}
	public void setUsuario(int usuario) {
		this.usuario = usuario;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTransactionCode() {
		return transactionCode;
	}
	public void setTransactionCode(String transactionCode) {
		this.transactionCode = transactionCode;
	}
	public List<ItemPedidoBean> getItems() {
		return items;
	}
	public void setItems(List<ItemPedidoBean> items) {
		this.items = items;
	}
	

}