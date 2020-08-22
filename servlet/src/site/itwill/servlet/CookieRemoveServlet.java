package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//Ŭ���̾�Ʈ�� ����� ��Ű�� �����ϰ� ���乮���� �����ϴ� ����
@WebServlet("/remove.itwill")
public class CookieRemoveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//Ŭ���̾�Ʈ���� ������ ��� ��Ű�� ��ȯ�޾� ����
		Cookie[] cookies=request.getCookies();
		
		if(cookies!=null) {
			for(Cookie cookie:cookies) {
				//Ŭ���̾�Ʈ���� ������ ��� Cookie �ν��Ͻ��� ���ӽð��� 0���� ���� 
				cookie.setMaxAge(0);
				//���ӽð��� ����� Cookie �ν��Ͻ��� Ŭ���̾�Ʈ���� ����
				// => Cookie �ν��Ͻ��� ���޹��� Ŭ���̾�Ʈ�� ���ӽð��� ���� ��Ű �Ҹ�
				response.addCookie(cookie);
			}
		}
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>��Ű ����</h1>");
		out.println("<hr>");
		out.println("<p>�� �ȿ� ��Ű ����.</p>");
		out.println("<hr>");
		out.println("<p><a href='read.itwill'>��Ű �б�</a></p>");
		out.println("</body>");
		out.println("</html>");	
	}
}