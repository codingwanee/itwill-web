package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//클라이언트에서 제공된 쿠키값을 얻어와 응답문서로 전달하는 서블릿
// => 클라이언트에 서버 문서를 요청할 경우 서버이름으로 저장된 모든 쿠키를 리퀘스트 메세지로 전달
@WebServlet("/read.itwill")
public class CookieReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//HttpServletRequest.getCookies() : 클라이언트가 
		//제공하는 모든 쿠키(Cookie 인스턴스 배열)를 반환하는 메소드
		// => 클라이언트가 제공한 쿠키가 없는 경우 null 반환
		Cookie[] cookies=request.getCookies();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>쿠키 읽기</h1>");
		out.println("<hr>");
		if(cookies==null) {
			out.println("<p>네 안에 쿠키 없다.</p>");
		} else {
			String id="";
			String count="";
			
			for(Cookie cookie:cookies) {
				//Cookie.getName() : 쿠키명을 반환하는 메소드
				if(cookie.getName().equals("id")) {
					//Cookie.getValue() : 쿠키값을 반환하는 메소드
					id=cookie.getValue();
				} else if(cookie.getName().equals("count")) {
					count=cookie.getValue();
				}
			}
			
			if(!id.equals("")) {
				out.println("<p>아이디 = "+id+"</p>");
			}
			
			if(!count.equals("")) {
				int cnt=Integer.parseInt(count)+1;
				out.println("<p>요청 횟수 = "+cnt+"</p>");
				
				//클라이언트에 이미 존재하는 쿠키명을 전달할 경우 덮어씌우기
				Cookie countCookie=new Cookie("count", cnt+"");
				countCookie.setMaxAge(24*60*60);
				response.addCookie(countCookie);
			}
		}
		out.println("<hr>");
		out.println("<p><a href='create.itwill'>쿠키 전달</a></p>");
		out.println("<p><a href='remove.itwill'>쿠키 제거</a></p>");
		out.println("</body>");
		out.println("</html>");	
	}

}
