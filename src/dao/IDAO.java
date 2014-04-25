package dao;

import java.util.List;

public interface IDAO<T> {

	T carregar(int id) throws Exception;

	List<T> carregarTodos() throws Exception;

	List<T> pesquisar(String texto, List<String> campos) throws Exception;

	void gravar(T obj, boolean update) throws Exception;

	int deletar(int id) throws Exception;

}
