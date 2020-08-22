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

//WAS에서 제공하는 DBCP 기능을 이용하여 Connection 정보를 응답문서로 제공하는 서블릿
//DBCP(DataBase Connection Pool) : 다수의 Connection 인스턴스를 미리 생성한 후 저장하여 제공하는 기능
@WebServlet("/dbcp.itwill")
public class DbcpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//tomcat-dbcp.jar >> BasicDataSource 클래스 : DBCP 클래스
		//BasicDataSource 클래스로 인스턴스 생성
		BasicDataSource ds=new BasicDataSource();

		//BasicDataSource 인스턴스에 Connection 인스턴스 생성에 필요한 정보들을 메소드를 호출하여 전달(변경)
		ds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		ds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		ds.setUsername("scott");
		ds.setPassword("tiger");
		//최초 생성되어 저장되는 Connection 인스턴스의 갯수 변경
		ds.setInitialSize(10);
		//대기 상태의 Connection 인스턴스의 갯수 변경
		ds.setMaxIdle(10);
		//최대 생성하여 제공 가능한 Connection 인스턴스의 갯수 변경
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
			out.println("<h3>Connection 제공 후</h3>");
			//ConnectionPool에서 사용상태인 Connection 인스턴스의 갯수
			out.println("<p>DBCP : Connection Active Number = "+ds.getNumActive()+"</p>");
			//ConnectionPool에서 대기상태인 Connection 인스턴스의 갯수
			out.println("<p>DBCP : Connection Idle Number = "+ds.getNumIdle()+"</p>");
			con.close();
	
			out.println("<hr>");
			out.println("<h3>Connection 제거 후</h3>");
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



