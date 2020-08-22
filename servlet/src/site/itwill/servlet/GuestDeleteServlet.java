package site.itwill.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import site.itwill.dao.GuestDAO;

//글번호를 전달받아 GUEST 테이블의 해당 행을 제거하고 출력페이지(select.itwill)로 이동하는 서블릿
@WebServlet("/delete.itwill")
public class GuestDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//비정상적인 요청(전달된 글번호가 없는 경우)에 대한 응답 처리
		if(request.getParameter("no")==null) {
			//클리이언트에게 에러코드 400 전달
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		//전달받은 글번호를 반환받아 저장
		int no=Integer.parseInt(request.getParameter("no"));
		
		//GUEST 테이블의 행을 삭제하는 DAO 클래스의 메소드 호출
		int rows=GuestDAO.getDAO().removeGuest(no);
	
		if(rows>0) {
			//클라이언트에게 301 코드(문서요청)와 요청문서의
			//URL를 전달하여 출력페이지 이동 => 리다이렉트 이동
			response.sendRedirect("select.itwill");
		} else {
			//비정상적인 요청(삭제행이 없는 경우)에 대한 응답 처리
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		}
		
	}
}



