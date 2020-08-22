package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("UrlPattern") : 서블릿 클래스를 서블릿으로
//등록 후 URL 주소로 매핑 설정하기 위한 어노테이션(Annotation)
// => web.xml 파일의 servlet 엘리먼트 및 servlet-mapping 엘리먼트와 동일한 기능 제공
@WebServlet("/first.itwill")
public class FirstServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//서버에서 정보를 제공하여 클라이언트 전달
		// => 클라이언트에 일관성 있는 정보를 제공하는 동적 페이지 구현
		Date now=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat
				("yyyy년 MM월 dd일 HH시 mm분 ss초");
		String displayNow=sdf.format(now);
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("<style type='text/css'>");
		out.println("p { width: 600px; margin: 0 auto;"
			+"padding: 30px 0; font-size: 2em;"
			+"font-weight: bold;text-align: center;"
			+"border: 2px solid black;}"); 
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>서블릿 디지털 시계</h1>");
		out.println("<hr>");
		out.println("<p>"+displayNow+"</p>");
		out.println("<script type='text/javascript'>");
		out.println("setInterval(function() { location.reload(); }, 1000);");
		out.println("</script>");
	}
}






