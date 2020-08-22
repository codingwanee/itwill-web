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

//Ŭ���̾�Ʈ�� ���� ���������� ���乮���� �����ϴ� ����
//����(Session) : ���� ���Ӽ��� �����ϱ� ���� ������ ����Ǵ� ����
@WebServlet("/session.itwill")
public class SessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//HttpServletRequest.getSession() : ����(HttpSession �ν��Ͻ�)�� ���ε��Ͽ� ��ȯ�ϴ� �޼ҵ�
		// => Ŭ���̾�Ʈ�� ���Ǿ��̵�(JSESSIONID)�� ���ų� ���� Ž���� ������ ��� ������ �����Ͽ� ���ε� �ϰ� ��ȯ   
		// => Ŭ���̾�Ʈ�� ���Ǿ��̵� �ش��ϴ� ������ Ž���� ��� ������ ���ε� �ϰ� ��ȯ 
		// => ������ ���ε� �Ǿ�߸� �������� ���� ���
		// => ������ �����Ǿ� ���ε��� ��� ���Ǿ��̵� ��Ű(��Ű��:JSESSIONID,���ӽð�:-1)�� Ŭ���̾�Ʈ�� �����Ͽ� ����

		//HttpServletRequest.getSession(boolean create) : ������ ���ε��Ͽ� ��ȯ�ϴ� �޼ҵ�
		// => �Ķ���Ϳ� false�� ���޵� ��� ���� ���� �Ұ����ϰ� Ž���Ͽ� ���ε� ����
		// => �Ķ���Ϳ� true�� ���޵� ��� ���� ���� �� Ž���Ͽ� ���ε� ����
		//HttpSession session=request.getSession(false);

		//���� Ʈ��ŷ(Session Tracking) : Ŭ���̾�Ʈ���� ���޵� ���Ǿ��̵�� ������ ������ ã�� �۾� 
		//���� ���ε�(Session Binding) : WAS�� �����̳ʰ� �����ϴ� ������ �������� ����� �� �ֵ��� �����ϴ� �۾�
		//HttpSession �ν��Ͻ� : Ŭ���̾�Ʈ�� �������� ���Ǹ�(String)�� ���ǰ�(Object)�� ���·� �����ϱ� ���� WAS�� �����ϴ� �ν��Ͻ� 
		HttpSession session=request.getSession();
		
		//HttpSession.setAttribute(String attributeName,Object attributeValue)
		// => ���ǼӼ���(String)�� ���ǼӼ���(Object)�� ������ ���ǿ� ������ �����ϴ� �޼ҵ�
		// => ���ǼӼ����� �ߺ��� ��� ������
		session.setAttribute("now", new Date());
		
		//HttpSession.getAttribute(String attributeName)
		// => ���ǼӼ���(String)���� ���ǼӼ����� ��ȯ�ϴ� �޼ҵ�
		// => ���ǼӼ����� Object �ν��Ͻ��� ��ȯ�ϹǷ� ��ü����ȯ�Ͽ� ���
		// => ���ǼӼ����� ���� ��� null ��ȯ 
		Date now=(Date)session.getAttribute("now");
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>����(Session)</h1>");
		out.println("<hr>");
		//HttpSession.isNew() : ������ Ž���Ͽ� ���ε��� ��� false ��ȯ, �����Ͽ� ���ε��� ��� true�� ��ȯ�ϴ� �޼ҵ�
		if(session.isNew()) {
			out.println("<p>������ �����Ͽ� ���ε� �Ǿ����ϴ�.</p>");
			
			//�������� JSESSIONID�� ��Ű�� �����Ͽ� Ŭ���̾�Ʈ ����
			// => JSESSIONID�� ��Ű ���ӽð� ����
			Cookie cookie=new Cookie("JSESSIONID", session.getId());
			cookie.setMaxAge(24*60*60);
			response.addCookie(cookie);			
		} else {
			out.println("<p>������ Ž���Ͽ� ���ε� �Ǿ����ϴ�.</p>");
		}
		
		//session.getId() : ���Ǿ��̵� ��ȯ�ϴ� �޼ҵ�
		// => Ŭ���̾�Ʈ�� ����� JSESSIONID ��Ű���� ����
		out.println("<p>���� ���̵� = "+session.getId()+"</p>");
		//session.getCreationTime() : ���� �����ð�(Ÿ�ӽ�����)�� ��ȯ�ϴ� �޼ҵ�
		out.println("<p>���� �����ð� = "+session.getCreationTime()+"</p>");
		//session.getMaxInactiveInterval() : ���� ���ӽð�(��)�� ��ȯ�ϴ� �޼ҵ�
		//session.setMaxInactiveInterval(int interval) �޼ҵ� �Ǵ� web.xml ���Ͽ��� ������ ���ӽð� ���� ����
		out.println("<p>���� ���ӽð� = "+session.getMaxInactiveInterval()+"</p>");
		out.println("<p>���ǼӼ��� = "+now+"</p>");
		out.println("</body>");
		out.println("</html>");			
	}
}
