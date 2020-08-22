package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

//WAS���� �����ϴ� DBCP ����� �̿��Ͽ� Connection ������ ���乮���� �����ϴ� ����
//DBCP(DataBase Connection Pool) : �ټ��� Connection �ν��Ͻ��� �̸� ������ �� �����Ͽ� �����ϴ� ���
@WebServlet("/dbcp.itwill")
public class DbcpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//tomcat-dbcp.jar >> BasicDataSource Ŭ���� : DBCP Ŭ����
		//BasicDataSource Ŭ������ �ν��Ͻ� ����
		BasicDataSource ds=new BasicDataSource();

		//BasicDataSource �ν��Ͻ��� Connection �ν��Ͻ� ������ �ʿ��� �������� �޼ҵ带 ȣ���Ͽ� ����(����)
		ds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		ds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		ds.setUsername("scott");
		ds.setPassword("tiger");
		//���� �����Ǿ� ����Ǵ� Connection �ν��Ͻ��� ���� ����
		ds.setInitialSize(10);
		//��� ������ Connection �ν��Ͻ��� ���� ����
		ds.setMaxIdle(10);
		//�ִ� �����Ͽ� ���� ������ Connection �ν��Ͻ��� ���� ����
		ds.setMaxTotal(20);
		
		try {
			Connection con=ds.getConnection();
			
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>Apache DBCP</h1>");
			out.println("<hr>");
			out.println("<p>Connection = "+con+"</p>");
			out.println("<hr>");
			out.println("<h3>Connection ���� ��</h3>");
			//ConnectionPool���� �������� Connection �ν��Ͻ��� ����
			out.println("<p>DBCP : Connection Active Number = "+ds.getNumActive()+"</p>");
			//ConnectionPool���� �������� Connection �ν��Ͻ��� ����
			out.println("<p>DBCP : Connection Idle Number = "+ds.getNumIdle()+"</p>");
			con.close();
	
			out.println("<hr>");
			out.println("<h3>Connection ���� ��</h3>");
			out.println("<p>DBCP : Connection Active Number = "+ds.getNumActive()+"</p>");
			out.println("<p>DBCP : Connection Idle Number = "+ds.getNumIdle()+"</p>");
			out.println("</body>");
			out.println("</html>");

			ds.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}



