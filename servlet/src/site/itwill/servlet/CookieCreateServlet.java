package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//응답문서와 쿠키를 클라이언트에게 전달하는 서블릿 
@WebServlet("/create.itwill")
public class CookieCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//Cookie 클래스 : 클라이언트와의 연결 지속성을 제공할 정보를 저장하기 위한 클래스
		// => 쿠키명(String)과 쿠키값(String)을 하나의 쌍(Entry)으로 클라이언트에게 전달하여 저장
		// => 쿠키명과 쿠키값으로 영문자,숫자,일부 특수문자만 표현 가능
		
		//Cookie 인스턴스 생성 - Cookie(String cookieName,String cookieValue) 생성자
		Cookie idCookie=new Cookie("id", "abc123");
		Cookie countCookie=new Cookie("count", "0");
		
		//클라이언트에 저장될 쿠키의 최대 저장시간(지속시간) 변경 
		//Cookie.setMaxAge(int expire) : Cookie 인스턴스의 지속시간(초)을 변경하는 메소드
		// => Cookie 인스턴스의 메소드를 호출하지 않은 경우 쿠키 지속시간은 기본적으로 -1 저장 
		// => 지속시간이 -1로 설정된 경우 쿠키는 브라우저가 종료되면 소멸
		countCookie.setMaxAge(24*60*60);//지속시간 : 1일
		
		//Cookie 인스턴스를 클라이언트에게 전달 - 클라이언트에 쿠키 저장
		// => 지속시간을 변경하지 않은 Cookie 인스턴스는 브라우저 메모리에 저장
		// => 지속시간을 변경한 Cookie 인스턴스는 클라이언트의 쿠키파일에 저장
		//HttpServletResponse.addCookie(Cookie cookie) : 클라이언트에게 쿠키를 전달하는 메소드
		response.addCookie(idCookie);
		response.addCookie(countCookie);
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>쿠키 전달</h1>");
		out.println("<hr>");
		out.println("<p>네 안에 쿠키 있다.</p>");
		out.println("<hr>");
		out.println("<p><a href='read.itwill'>쿠키 읽기</a></p>");
		out.println("</body>");
		out.println("</html>");	
	}
}
