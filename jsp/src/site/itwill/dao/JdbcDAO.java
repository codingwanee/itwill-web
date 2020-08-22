package site.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//JDBC 기능을 구현하기 위한 DAO 클래스가 상속받아 사용하기 위한 클래스
// => DataSource 인스턴스로부터 Connection 인스턴스를 제공받아 반환하는 메소드
// => JDBC 자원을 제거하는 메소드
// => 상속이 목적인 클래스는 추상클래스로 선언하는 것을 권장
public abstract class JdbcDAO {
	private static DataSource ds;
	
	static {
		try {
			//JNDI로 등록된 자원을 이용하여 인스턴스 제공받아 저장
			ds=(DataSource)new InitialContext().lookup("java:comp/env/jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException {
		return ds.getConnection();
	}
	
	public void close(Connection con) {
		try {
			if(con!=null) con.close();
		} catch (SQLException e) {}
	}
	
	public void close(Connection con,PreparedStatement pstmt) {
		try {
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		} catch (SQLException e) {}
	}
	
	public void close(Connection con,PreparedStatement pstmt,ResultSet rs) {
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		} catch (SQLException e) {}
	}
}




