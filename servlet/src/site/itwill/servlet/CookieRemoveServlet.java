package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//클라이언트에 저장된 쿠키를 제거하고 응답문서로 전달하는 서블릿
@WebServlet("/remove.itwill")
public class CookieRemoveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//클라이언트에서 제공된 모든 쿠키를 반환받아 저장
		Cookie[] cookies=request.getCookies();
		
		if(cookies!=null) {
			for(Cookie cookie:cookies) {
				//클라이언트에서 제공된 모든 Cookie 인스턴스의 지속시간을 0으로 변경 
				cookie.setMaxAge(0);
				//지속시간이 변경된 Cookie 인스턴스를 클라이언트에게 전달
				// => Cookie 인스턴스를 전달받은 클라이언트는 지속시간에 의해 쿠키 소멸
				response.addCookie(cookie);
			}
		}
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>쿠키 제거</h1>");
		out.println("<hr>");
		out.println("<p>네 안에 쿠키 없다.</p>");
		out.println("<hr>");
		out.println("<p><a href='read.itwill'>쿠키 읽기</a></p>");
		out.println("</body>");
		out.println("</html>");	
	}
}