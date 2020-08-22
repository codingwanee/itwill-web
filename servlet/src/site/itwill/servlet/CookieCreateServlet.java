package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//���乮���� ��Ű�� Ŭ���̾�Ʈ���� �����ϴ� ���� 
@WebServlet("/create.itwill")
public class CookieCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//Cookie Ŭ���� : Ŭ���̾�Ʈ���� ���� ���Ӽ��� ������ ������ �����ϱ� ���� Ŭ����
		// => ��Ű��(String)�� ��Ű��(String)�� �ϳ��� ��(Entry)���� Ŭ���̾�Ʈ���� �����Ͽ� ����
		// => ��Ű��� ��Ű������ ������,����,�Ϻ� Ư�����ڸ� ǥ�� ����
		
		//Cookie �ν��Ͻ� ���� - Cookie(String cookieName,String cookieValue) ������
		Cookie idCookie=new Cookie("id", "abc123");
		Cookie countCookie=new Cookie("count", "0");
		
		//Ŭ���̾�Ʈ�� ����� ��Ű�� �ִ� ����ð�(���ӽð�) ���� 
		//Cookie.setMaxAge(int expire) : Cookie �ν��Ͻ��� ���ӽð�(��)�� �����ϴ� �޼ҵ�
		// => Cookie �ν��Ͻ��� �޼ҵ带 ȣ������ ���� ��� ��Ű ���ӽð��� �⺻������ -1 ���� 
		// => ���ӽð��� -1�� ������ ��� ��Ű�� �������� ����Ǹ� �Ҹ�
		countCookie.setMaxAge(24*60*60);//���ӽð� : 1��
		
		//Cookie �ν��Ͻ��� Ŭ���̾�Ʈ���� ���� - Ŭ���̾�Ʈ�� ��Ű ����
		// => ���ӽð��� �������� ���� Cookie �ν��Ͻ��� ������ �޸𸮿� ����
		// => ���ӽð��� ������ Cookie �ν��Ͻ��� Ŭ���̾�Ʈ�� ��Ű���Ͽ� ����
		//HttpServletResponse.addCookie(Cookie cookie) : Ŭ���̾�Ʈ���� ��Ű�� �����ϴ� �޼ҵ�
		response.addCookie(idCookie);
		response.addCookie(countCookie);
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>��Ű ����</h1>");
		out.println("<hr>");
		out.println("<p>�� �ȿ� ��Ű �ִ�.</p>");
		out.println("<hr>");
		out.println("<p><a href='read.itwill'>��Ű �б�</a></p>");
		out.println("</body>");
		out.println("</html>");	
	}
}
