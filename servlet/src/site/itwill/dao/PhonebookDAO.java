package site.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import site.itwill.dto.PhonebookDTO;

//DAO Ŭ���� : ����Ÿ ����Ҹ� �̿��Ͽ� ����Ÿ ����,����,����,�˻� ����� �����ϴ� Ŭ����

//PHONEBOOK ���̺��� �� ����,����,����,�˻� ����� �޼ҵ带 �����ϴ� Ŭ����
// => �̱��� Ŭ������ �ۼ��ϴ� ���� ����
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
	
	//PHONEBOOK ���̺� ����� ��� ���� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			
			//�ټ��� �˻����� List �ν��Ͻ��� ��ȯ
			while(rs.next()) {
				//DTO �ν��Ͻ� ����
				PhonebookDTO phonebook=new PhonebookDTO();
				//�˻����� �÷����� �̿��Ͽ� DTO �ν��Ͻ��� �ʵ尪 ����
				phonebook.setPhone(rs.getString("phone"));
				phonebook.setName(rs.getString("name"));
				phonebook.setAddress(rs.getString("address"));
				//DTO �ν��Ͻ��� List �ν��Ͻ��� �߰�
				phonebookList.add(phonebook);
			}
		} catch (SQLException e) {
			System.out.println("[����]getPhonebookList() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return phonebookList;
	}
}
