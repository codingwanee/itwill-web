package site.itwill.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import site.itwill.dao.GuestDAO;
import site.itwill.dto.GuestDTO;

//입력페이지(insert.html)에서 전달된 입력값을 반환받아 GUEST 테이블에
//저장하고 출력페이지(select.itwill)로 이동하는 서블릿 => 처리페이지 
@WebServlet("/insert.itwill")
public class GuestInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//비정상적인 요청(GET 방식의 요청)에 대한 응답 처리 
		if(request.getMethod().equals("GET")) {
			//클리이언트에게 에러코드 405 전달
			response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return;
		}
		
		//입력페이지의 전달값에 대한 캐릭터셋 변경
		request.setCharacterEncoding("UTF-8");
		
		//입력페이지의 전달값을 반환받아 저장
		// => 모든 입력값에 대한 앞 또는 뒤의 공백 제거
		// => XSS 공격에 대한 방어로 스크립트 기호를 Escape 문자로 변환
		//XSS 해킹 : 입력태그에 스트립트를 입력하여 사이트를 공격하는 방법 
		String name=request.getParameter("name").trim().replace("<", "&lt;").replace(">", "&gt;");
		String email=request.getParameter("email").trim().replace("<", "&lt;").replace(">", "&gt;");
		String homepage=request.getParameter("homepage").trim().replace("<", "&lt;").replace(">", "&gt;");
		String title=request.getParameter("title").trim().replace("<", "&lt;").replace(">", "&gt;");
		String content=request.getParameter("content").trim().replace("<", "&lt;").replace(">", "&gt;");
		
		//DTO 클래스로 인스턴스 생성하고 입력값으로 필드값 변경
		GuestDTO guest=new GuestDTO();
		guest.setName(name);
		guest.setEmail(email);
		guest.setHomepage(homepage);
		guest.setTitle(title);
		guest.setContent(content);
		
		//GUEST 테이블에 방명록 글을 저장하는 DAO 클래스의 메소드 호출
		GuestDAO.getDAO().addGuest(guest);
		
		//클라이언트에게 301 코드(문서요청)와 요청문서의
		//URL를 전달하여 출력페이지 이동 => 리다이렉트 이동
		response.sendRedirect("select.itwill");
	}
}