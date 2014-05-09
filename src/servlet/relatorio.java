package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.sql.*;
import java.util.*;

import net.sf.jasperreports.engine.*;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;


/**
 * Servlet implementation class relatorio
 */
@WebServlet("/relatorio")
public class relatorio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public relatorio() {
        super();
    }

    @SuppressWarnings("rawtypes")
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    	
    	String jasp = "/web/sukces-produtos.jasper";
    	
    	String option = request.getParameter("option");
    	jasp = option;
    	if(option == "usuario"){
    		jasp = "/web/usuario-sukces.jasper";
    	}else if (option == "produto"){
    		jasp = "/web/sukces-produtos.jasper";
    	}
		
		Connection con = null;
		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost/sukces", "root", "");
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
		}catch(SQLException e)  {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<html><head>");
			out.println("<title>Servlet relatorio</title>");
			out.println("</head><body>");
			out.println("<h1>Erro de SQL (" + e.getMessage() +
			") no Servlet relatorio at " +
			request.getContextPath () + "</h1>");
			out.println("</body></html>");
			out.flush();
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }

}
