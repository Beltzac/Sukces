package dao;

import java.util.List;

public interface IDAO<T> {

	T carregar(int id) throws Exception;

	List<T> carregarTodos() throws Exception;

	List<T> pesquisar(String texto, String[] campos) throws Exception;

	void gravar(T obj) throws Exception;

	int deletar(int id) throws Exception;

}
