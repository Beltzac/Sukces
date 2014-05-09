package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperRunManager;
import dao.ConnectionFactory;


@WebServlet("/relatorio")
public class relatorio extends Servlet {
	private static final long serialVersionUID = 1L;       

    public relatorio() {
        super();
    }

    @SuppressWarnings("rawtypes")
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    	if (!filtroAdmin(request, response)) {
			return;
		}
    	
    	String jasp;
    	
    	switch (request.getParameter("option")) {
		case "usuarios":
			jasp = "/web/usuario-sukces.jasper";
			break;
			
		case "produtos":
			jasp = "/web/sukces-produtos.jasper";
			break;
		
		default:
			paginaErro(request, response, "Erro ao criar relatório (Parâmetro não existente)", null);
			return;			
		}
    	
		Connection con = null;
		try {
			con = ConnectionFactory.getConnection();
			String jasper = request.getContextPath() + jasp;
			String host = "http://" + request.getServerName() + ":" + request.getServerPort();
			URL jasperURL = new URL(host + jasper);
			HashMap params = new HashMap();
			byte[] bytes = null;
			bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
			if (bytes != null) {
				response.setContentType("application/pdf");
				OutputStream ops = null;
				ops = response.getOutputStream();
				ops.write(bytes);
			}
		}catch (JRException e) {
			e.printStackTrace();
			paginaErro(request, response, "Erro ao criar relatório", e.getMessage());
			return;
		}
    	
    }

}
