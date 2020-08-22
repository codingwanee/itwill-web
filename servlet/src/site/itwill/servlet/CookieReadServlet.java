package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Ŭ���̾�Ʈ���� ������ ��Ű���� ���� ���乮���� �����ϴ� ����
// => Ŭ���̾�Ʈ�� ���� ������ ��û�� ��� �����̸����� ����� ��� ��Ű�� ������Ʈ �޼����� ����
@WebServlet("/read.itwill")
public class CookieReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//HttpServletRequest.getCookies() : Ŭ���̾�Ʈ�� 
		//�����ϴ� ��� ��Ű(Cookie �ν��Ͻ� �迭)�� ��ȯ�ϴ� �޼ҵ�
		// => Ŭ���̾�Ʈ�� ������ ��Ű�� ���� ��� null ��ȯ
		Cookie[] cookies=request.getCookies();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>��Ű �б�</h1>");
		out.println("<hr>");
		if(cookies==null) {
			out.println("<p>�� �ȿ� ��Ű ����.</p>");
		} else {
			String id="";
			String count="";
			
			for(Cookie cookie:cookies) {
				//Cookie.getName() : ��Ű���� ��ȯ�ϴ� �޼ҵ�
				if(cookie.getName().equals("id")) {
					//Cookie.getValue() : ��Ű���� ��ȯ�ϴ� �޼ҵ�
					id=cookie.getValue();
				} else if(cookie.getName().equals("count")) {
					count=cookie.getValue();
				}
			}
			
			if(!id.equals("")) {
				out.println("<p>���̵� = "+id+"</p>");
			}
			
			if(!count.equals("")) {
				int cnt=Integer.parseInt(count)+1;
				out.println("<p>��û Ƚ�� = "+cnt+"</p>");
				
				//Ŭ���̾�Ʈ�� �̹� �����ϴ� ��Ű���� ������ ��� ������
				Cookie countCookie=new Cookie("count", cnt+"");
				countCookie.setMaxAge(24*60*60);
				response.addCookie(countCookie);
			}
		}
		out.println("<hr>");
		out.println("<p><a href='create.itwill'>��Ű ����</a></p>");
		out.println("<p><a href='remove.itwill'>��Ű ����</a></p>");
		out.println("</body>");
		out.println("</html>");	
	}

}
