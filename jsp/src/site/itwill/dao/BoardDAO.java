package site.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import site.itwill.dto.BoardDTO;

public class BoardDAO extends JdbcDAO {
	private static BoardDAO _dao;
	
	private BoardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new BoardDAO();
	}
	
	public static BoardDAO getDAO() {
		return _dao;
	}
	
	//검색대상과 검색키워드를 전달받아 BOARD 테이블에 저장된 검색키워드 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색대상이 없는 경우 BOARD 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 메소드
	public int getBoardTotal(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int rows=0;
		try {
			con=getConnection();
			
			//메소드의 파라메터에 전달된 값에 따라 다른 SQL   
			//명령을 저장하여 전달되도록 설정 - 동적 SQL
			if(keyword.equals("")) {//검색 기능 미사용
				String sql="select count(*) from board";
				pstmt=con.prepareStatement(sql);
			} else {//검색 기능 사용
				//컬럼명을 저장한 Java 변수는 InParameter로 사용 불가능
				String sql="select count(*) from board where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				rows=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]getBoardTotal() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return rows;
	}
	
	//시작 행번호와 종료 행번호를 전달받아 BOARD 테이블에 저장된 게시글 목록을 페이지 단위로 검색하여 반환하는 메소드
	// => 테이블에 저장된 행에 대한 페이징 처리
	public List<BoardDTO> getBoardList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			con=getConnection();
		
			if(keyword.equals("")) {	
				String sql="select * from (select rownum rn, temp.* from (select * from board order by ref desc,re_step) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn, temp.* from (select * from board where "
					+search+" like '%'||?||'%' and status!=9 order by ref desc,re_step) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setReStep(rs.getInt("re_step"));
				board.setReLevel(rs.getInt("re_Level"));
				board.setContent(rs.getString("content"));
				board.setIp(rs.getString("ip"));
				board.setStatus(rs.getInt("status"));
				boardList.add(board);
			}
		} catch (SQLException e) {
			System.out.println("[에러]getBoardList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	
	//BOARD_SEQ 시퀸스의 자동 증가값을 검색하여 반환하는 메소드
	public int getBoardNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int num=0;
		try {
			con=getConnection();
			
			String sql="select board_seq.nextval from dual";					
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]getBoardNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return num;
	}
	
	//게시글 정보를 전달받아 BOARD 테이블에 저장하고 저장행의 갯수를 반환하는 메소드
	public int addBoard(BoardDTO board) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into board values(?,?,?,?,sysdate,0,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getId());
			pstmt.setString(3, board.getWriter());
			pstmt.setString(4, board.getSubject());
			pstmt.setInt(5, board.getRef());
			pstmt.setInt(6, board.getReStep());
			pstmt.setInt(7, board.getReLevel());
			pstmt.setString(8, board.getContent());
			pstmt.setString(9, board.getIp());
			pstmt.setInt(10, board.getStatus());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]addBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//부모글 정보를 전달받아 BOARD 테이블에 저장된 게시글에서 같은 그룹의 순서가 
	//높은 게시글의 순서값을 1 증가되도록 변경하고 변경행을 반환하는 메소드
	// => 새로운 답글을 기존 답글보다 먼저 검색되도록 설정
	public int modifyReSetp(int ref,int reStep) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update board set re_step=re_step+1 where ref=? and re_step>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reStep);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]modifyReSetp() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//게시글 번호를 전달받아 BOARD 테이블에 저장된 게시글을 검색하여 반환하는 메소드
	public BoardDTO getBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO board=null;
		try {
			con=getConnection();
			
			String sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setReStep(rs.getInt("re_step"));
				board.setReLevel(rs.getInt("re_Level"));
				board.setContent(rs.getString("content"));
				board.setIp(rs.getString("ip"));
				board.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]getBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	//게시글 번호를 전달받아 BOARD 테이블에 저장된 게시글의 조회수가 1 증가 되도록 변경하고 변경행의 갯수를 반환하는 메소드
	public int modifyReadCount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update board set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]modifyReadCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//게시글 번호를 전달받아 BOARD 테이블에 저장된 게시글을 삭제 처리하고 변경행의 갯수를 반환하는 메소드
	public int removeBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update board set status=9 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]removeBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//게시글을 전달받아 BOARD 테이블에 저장된 게시글을 변경하고 변경행의 갯수를 반환하는 메소드
	public int modifyBoard(BoardDTO board) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update board set subject=?,status=?,content=? where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setInt(2, board.getStatus());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]modifyBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}








