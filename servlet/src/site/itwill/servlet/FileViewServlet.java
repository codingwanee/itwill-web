package site.itwill.servlet;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//�Է����������� ���޵� �Է°��� �Է������� ��ȯ�޾� 
//Ŭ���̾�Ʈ���� ���乮���� �����ϴ� ����
@WebServlet("/view.itwill")
public class FileViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//���������� ��û�� ���� ó�� - �����ڵ� ���� �Ǵ� ���������� �̵�
		if(request.getMethod().equals("GET")) {
			response.sendRedirect("file_view.html");
			return;
		}
		
		//������Ʈ �޼����� ���� ĳ���ͼ� ����
		request.setCharacterEncoding("UTF-8");
		
		//�Է� ���ް�(�ø���)�� ��ȯ�޾� ����
		//form �±��� enctype �Ӽ��� �Ӽ������� "multipart/form-data"�� ������ 
		//��� ��� �Է°� �� �Է������� �ϳ��� ���յ� ������ ���õ���Ÿ�� ����
		// => �Է°��� ���������� ��ȯ�޾� ��� �Ұ���
		String name=request.getParameter("name");
		
		//���乮���� �����Ͽ� Ŭ���̾�Ʈ���� ����
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>�Է°� �� �Է����� ���� Ȯ��</h1>");
		out.println("<hr>");
		out.println("<p>�ø��� = "+name+"</p>");
		out.println("<hr>");
		//form �±��� enctype �Ӽ��� �Ӽ������� "multipart/form-data"�� ������ 
		//��� ��� �Է°� �� �Է������� �������� �� �ִ� �Է½�Ʈ���� ��ȯ�޾� ����
		//HttpServletRequest.getInputStream() 
		// => ������Ʈ �޼����� ���õ���Ÿ�� �б� ���� �Է½�Ʈ��
		//    (ServletInputStream �ν��Ͻ�)�� ��ȯ�ϴ� �޼ҵ�
		//ServletInputStream in=request.getInputStream();
		InputStreamReader in=new InputStreamReader
				(request.getInputStream(), "UTF-8");
		
		//�Է½�Ʈ������ �о���� ����Ÿ�� Ŭ���̾�Ʈ�� ���乮���� ����
		out.println("<pre>");
		while(true) {
			int readByte=in.read();
			if(readByte==-1) break;
			out.write(readByte);
		}
		out.println("</pre>");
		out.println("</body>");
		out.println("</html>");	
	}

}





