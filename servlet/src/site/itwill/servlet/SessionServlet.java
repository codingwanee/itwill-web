package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//클라이언트에 대한 세션정보을 응답문서로 제공하는 서블릿
//세션(Session) : 연결 지속성을 제공하기 위해 서버에 저장되는 정보
@WebServlet("/session.itwill")
public class SessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//HttpServletRequest.getSession() : 세션(HttpSession 인스턴스)을 바인딩하여 반환하는 메소드
		// => 클라이언트의 세션아이디(JSESSIONID)가 없거나 세션 탐색이 실패한 경우 세션을 생성하여 바인딩 하고 반환   
		// => 클라이언트의 세션아이디에 해당하는 세션이 탐색된 경우 세션을 바인딩 하고 반환 
		// => 세션이 바인딩 되어야만 서블릿에서 세션 사용
		// => 세션이 생성되어 바인딩된 경우 세션아이디를 쿠키(쿠키명:JSESSIONID,지속시간:-1)로 클라이언트에 전달하여 저장

		//HttpServletRequest.getSession(boolean create) : 세션을 바인딩하여 반환하는 메소드
		// => 파라메터에 false가 전달될 경우 세션 생성 불가능하고 탐색하여 바인딩 가능
		// => 파라메터에 true가 전달될 경우 세션 생성 및 탐색하여 바인딩 가능
		//HttpSession session=request.getSession(false);

		//세션 트랙킹(Session Tracking) : 클라이언트에서 전달된 세션아이디와 동일한 세션을 찾는 작업 
		//세션 바인딩(Session Binding) : WAS의 컨테이너가 관리하는 세션을 서블릿에서 사용할 수 있도록 제공하는 작업
		//HttpSession 인스턴스 : 클라이언트의 정보들을 세션명(String)과 세션값(Object)의 형태로 저장하기 위해 WAS가 제공하는 인스턴스 
		HttpSession session=request.getSession();
		
		//HttpSession.setAttribute(String attributeName,Object attributeValue)
		// => 세션속성명(String)과 세션속성값(Object)의 쌍으로 세션에 정보를 저장하는 메소드
		// => 세션속성명이 중복될 경우 덮어씌우기
		session.setAttribute("now", new Date());
		
		//HttpSession.getAttribute(String attributeName)
		// => 세션속성명(String)으로 세션속성값을 반환하는 메소드
		// => 세션속성값을 Object 인스턴스로 반환하므로 객체형변환하여 사용
		// => 세션속성명이 없는 경우 null 반환 
		Date now=(Date)session.getAttribute("now");
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>세션(Session)</h1>");
		out.println("<hr>");
		//HttpSession.isNew() : 세션을 탐색하여 바인딩된 경우 false 반환, 생성하여 바인딩한 경우 true를 반환하는 메소드
		if(session.isNew()) {
			out.println("<p>세션을 생성하여 바인딩 되었습니다.</p>");
			
			//수동으로 JSESSIONID의 쿠키를 생성하여 클라이언트 전달
			// => JSESSIONID의 쿠키 지속시간 변경
			Cookie cookie=new Cookie("JSESSIONID", session.getId());
			cookie.setMaxAge(24*60*60);
			response.addCookie(cookie);			
		} else {
			out.println("<p>세션을 탐색하여 바인딩 되었습니다.</p>");
		}
		
		//session.getId() : 세션아이디를 반환하는 메소드
		// => 클라이언트에 저장된 JSESSIONID 쿠키값과 동일
		out.println("<p>세션 아이디 = "+session.getId()+"</p>");
		//session.getCreationTime() : 세션 생성시간(타임스탬프)을 반환하는 메소드
		out.println("<p>세션 생성시간 = "+session.getCreationTime()+"</p>");
		//session.getMaxInactiveInterval() : 세션 지속시간(초)을 반환하는 메소드
		//session.setMaxInactiveInterval(int interval) 메소드 또는 web.xml 파일에서 세션의 지속시간 변경 가능
		out.println("<p>세션 지속시간 = "+session.getMaxInactiveInterval()+"</p>");
		out.println("<p>세션속성값 = "+now+"</p>");
		out.println("</body>");
		out.println("</html>");			
	}
}
