package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//����(������ ���۵Ǵ� ���ø����̼�) �ۼ� ���
//1.HttpServlet Ŭ������ ��� �޾� �ۼ� - ���� Ŭ����
//=> HttpServlet Ŭ������ ��� ���� �ڽ� Ŭ������ ��ü ����ȭ Ŭ������
//   serialVersionUID �ʵ带 �����ϴ� ���� ����
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//2.doGet() �� doPost() �޼ҵ带 �������̵� ����
	// => Ŭ���̾�Ʈ ��û�� ���� ����� ������ ���� �ڵ� ȣ��Ǵ� �޼ҵ�
	// => doGet() : Ŭ���̾�Ʈ�� GET ��� ��û�� ���� ����� ���� �޼ҵ�
	// => doPost() : Ŭ���̾�Ʈ�� POST ��� ��û�� ���� ����� ���� �޼ҵ�
	// => doGet() �� doPost() �޼ҵ� ��� service() �޼ҵ� �������̵� ���� ����
	// => doGet() �� doPost() �޼ҵ庸�� service() �޼ҵ��� ȣ�� ������ ����.
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//WAS(Web Application Server)�� ���� �޼ҵ尡 ȣ��� �� HttpServletRequest �ν��Ͻ���
		//HttpServletResponse �ν��Ͻ��� �Ķ���Ϳ� �ڵ����� ���޵Ǿ� ����
		//HttpServletRequest �ν��Ͻ� : ������Ʈ �޼���(��û����)�� �����ϰ� �ִ� �ν��Ͻ�
		//HttpServletResponse �ν��Ͻ� : �������� �޼���(��������)�� �����ϰ� �ִ� �ν��Ͻ�
	
		//3.Ŭ���̾�Ʈ���� ������ ����(����) ����(Mime Type) ����
		// => ���� �������� ������ ��� ������ ĳ���ͼ�(Character Encoding) ����
		// => �⺻ ���� ���� ���� : text/html, ĳ���ͼ� : ISO-8859-1(��������)
		//�⺻ ���� ���� ������ ������� �ʰ� ���ϴ� ���� �������� ���޵ǵ��� ����
		//����) HttpServletResponse.setContentType(String MimeType[;charset=Encoding])
		// => ���� ���� ������ �����ϴ� �޼ҵ� - ĳ���ͼ� ����
		response.setContentType("text/html;charset=UTF-8");
		
		//4.Ŭ���̾�Ʈ���� ���� ����� ����(����)�ϱ� ���� ��½�Ʈ���� ��ȯ�޾� ����
		//����) HttpServletResponse.getOutputStream()
		// => ���õ���Ÿ(1Byte)�� ������ �� �ִ� ��½�Ʈ��(ServletOutputStream �ν��Ͻ�)�� ��ȯ�ϴ� �޼ҵ�
		// => �׸�, ����, ������ ���ϵ��� Ŭ���̾�Ʈ���� �����ϱ� ���� ����ϴ� ��½�Ʈ�� 
		//����) HttpServletResponse.getWriter()
		// => ���ڵ���Ÿ(2Byte)�� ������ �� �ִ� ��½�Ʈ��(PrintWriter �ν��Ͻ�)�� ��ȯ�ϴ� �޼ҵ�
		// => HTML, XML, Word ���ϵ�(�ؽ�Ʈ���� : ����)�� Ŭ���̾�Ʈ���� �����ϱ� ���� ����ϴ� ��½�Ʈ��
		PrintWriter out=response.getWriter();
		
		//5.Ŭ���̾�Ʈ ��û�� ���� ����� ����
		// => Ŭ���̾�Ʈ�� ��û���� �����޾� ó�� �� ������� Ŭ���̾�Ʈ���� ����
	
		//��½�Ʈ���� �޼ҵ带 ȣ���Ͽ� Ŭ���̾�Ʈ���� ����� ����
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>����(Servlet)</h1>");
		out.println("<hr>");
		out.println("<p>Hello. Servlet!!!</p>");
		out.println("</body>");
		out.println("</html>");
		
		//6.web.xml ���Ͽ� ���� Ŭ������ �������� ��� ��  
		//URL �ڿ����� ���� �����ؾ߸� ��û�� �޾� ����
	}
}




