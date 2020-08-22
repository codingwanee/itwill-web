package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

//WAS�� ��ϵ� Java �ڿ��� �̿��Ͽ� DataSource �ν��Ͻ�(DBCP)�� �����޾�
//Connection �ν��Ͻ� ������ ���乮���� �����ϴ� ����
@WebServlet("/jndi.itwill")
public class JndiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		try {
			//InitialContext : WAS�� ��ϵ� Java �ڿ��� �ҷ��� �ν��Ͻ��� ��ȯ�ϱ� ���� ����� �����ϴ� Ŭ����
			//InitialContext Ŭ������ �ν��Ͻ� ����
			InitialContext ic=new InitialContext();
			
			//InitialContext.lookup(String name) : WAS�� ��ϵ� Java �ڿ����� �ν��Ͻ��� �����Ͽ� ��ȯ�ϴ� �޼ҵ�
			// => �ν��Ͻ��� Object Ÿ������ ��ȯ�ϹǷ� ��ü ����ȯ�Ͽ� ���
			DataSource ds=(DataSource)ic.lookup("java:comp/env/jdbc/oracle");
			
			Connection con=ds.getConnection();
			
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>Apache DBCP(JNDI)</h1>");
			out.println("<hr>");
			out.println("<p>Connection = "+con+"</p>");
			out.println("</body>");
			out.println("</html>");
			
			con.close();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
