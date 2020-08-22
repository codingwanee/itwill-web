package site.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import site.itwill.dto.PhonebookDTO;

//DAO 클래스 : 데이타 저장소를 이용하여 데이타 삽입,삭제,변경,검색 기능을 제공하는 클래스

//PHONEBOOK 테이블의 행 삽입,삭제,변경,검색 기능의 메소드를 제공하는 클래스
// => 싱글톤 클래스로 작성하는 것을 권장
public class PhonebookDAO extends JdbcDAO {
	private static PhonebookDAO _dao;
	
	private PhonebookDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new PhonebookDAO();
	}
	
	public static PhonebookDAO getDAO() {
		return _dao;
	}
	
	//PHONEBOOK 테이블에 저장된 모든 행을 검색하여 반환하는 메소드
	public List<PhonebookDTO> getPhonebookList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PhonebookDTO> phonebookList=new ArrayList<PhonebookDTO>();
		try {
			con=getConnection();
			
			String sql="select * from phonebook order by name";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			//다수의 검색행을 List 인스턴스로 변환
			while(rs.next()) {
				//DTO 인스턴스 생성
				PhonebookDTO phonebook=new PhonebookDTO();
				//검색행의 컬럼값을 이용하여 DTO 인스턴스의 필드값 변경
				phonebook.setPhone(rs.getString("phone"));
				phonebook.setName(rs.getString("name"));
				phonebook.setAddress(rs.getString("address"));
				//DTO 인스턴스를 List 인스턴스에 추가
				phonebookList.add(phonebook);
			}
		} catch (SQLException e) {
			System.out.println("[에러]getPhonebookList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return phonebookList;
	}
}
