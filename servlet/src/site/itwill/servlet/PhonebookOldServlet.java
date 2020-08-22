package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//PHONEBOOK 테이블에 저장된 모든 행을 검색하여 응답문서로 제공하는 서블릿
@WebServlet("/old.itwill")
public class PhonebookOldServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1.OracleDriver 클래스를 읽어 메모리에 저장
			// => OracleDriver 인스턴스가 생성되어 DriverManager 클래스의 JDBC 드라이버로 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//2.DriverManager 클래스에 등록된 JDBC 드라이버를 이용하여 DBMS 서버에 접속
			// => Connection 인스턴스를 반환받아 저장
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			String user="scott";
			String password="tiger";
			con=DriverManager.getConnection(url, user, password);
			
			//3.Connection 인스턴스로부터 PreparedStatement 인스턴스를 반환받아 저장
			String sql="select * from phonebook order by name";
			pstmt=con.prepareStatement(sql);
			
			//4.PreparedStatement 인스턴스의 저장된 SQL 명령을 전달하여 실행결과를 반환받아 저장
			rs=pstmt.executeQuery();
					
			//5.반환받은 실행결과를 이용하여 응답 처리
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>전화번호부(JDBC)</h1>");
			out.println("<hr>");
			out.println("<table border='1' cellspacing='0' width='600'>");
			out.println("<tr>");
			out.println("<th>전화번호</th><th>이름</th><th>주소</th>");
			out.println("</tr>");

			while(rs.next()) {
				out.println("<tr align='center'>");
				out.println("<td>"+rs.getString("phone")+"</td>");
				out.println("<td>"+rs.getString("name")+"</td>");
				out.println("<td>"+rs.getString("address")+"</td>");
				out.println("</tr>");
			}
			
			out.println("</table>");
			out.println("</body>");
			out.println("</html>");			
		} catch (ClassNotFoundException e) {
			System.out.println("[에러]OracleDriver 클래스를 찾을 수 없습니다.");
		} catch (SQLException e) {
			System.out.println("[에러]SQL 에러 = "+e.getMessage());
		} finally {
			//6.JDBC 자원 제거
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {}
		}
	}

}


