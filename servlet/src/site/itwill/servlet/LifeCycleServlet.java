package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//������ Ŭ���̾�Ʈ�� ��û�� ���� WAS(Web Application Server)��
//�����̳ʰ� �ν��Ͻ��� �����Ͽ� ��û ó�� �� ���� ���� ����
// => ��û �ڿ��� ���� ���� �ν��Ͻ��� �̹� ������ ��� �ν��Ͻ� �̻���
// => ���� �ν��Ͻ��� WAS ����� �����̳ʿ� ���� �Ҹ�
// => �����̳ʴ� ���� �ν��Ͻ��� ����,���,�Ҹ�(�����ֱ�:LifeCycle) ����(����) ���
@WebServlet("/life.itwill")
public class LifeCycleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//������(Constructor) : �ν��Ͻ��� �����ϴ� Ư���� �޼ҵ�
	// => ���� �ν��Ͻ� ������ �ѹ��� ȣ�� : �ʱ�ȭ �۾�(�ʵ� �ʱⰪ �ο�)
	public LifeCycleServlet() {
		System.out.println("# LifeCycleServlet Ŭ������ �⺻ ������ ȣ�� #");
	}
	
	//init() : ���� �ν��Ͻ� ���� �� �����̳ʿ� ���� 
	//���� ���� �ڵ� ȣ��Ǵ� �޼ҵ� - �ѹ��� ȣ��
	// => ���� �ν��Ͻ��� ��û ó�� �� �ʱ�ȭ �۾�
	// => ������ ��� init() �޼ҵ�� �ʱ�ȭ �۾��� �ϴ� ������ ServletConfig �ν��Ͻ��� ���� �޾� ���
	//ServletConfig : web.xml ���Ͽ� �����ϴ� ������ �������� �� �ִ� ����� �ν��Ͻ� 
	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("# LifeCycleServlet Ŭ������ init() �޼ҵ� ȣ�� #");
	}
	
	//service() : Ŭ���̾�Ʈ�� ��û���� �����̳ʿ� ���� �ڵ� ȣ��Ǵ� �޼ҵ� 
	// => ��û�� ���� ó�� �� ���� ������ �����Ͽ� Ŭ���̾�Ʈ���� ����
	// => doGet() �� doPost() �޼ҵ嵵 ������ �۾��� �����ϴ� �޼ҵ�  
	// => �޼ҵ� ���� �Ǿ� ���� ���� ��� Ŭ���̾�Ʈ���� 405 �����ڵ� ���� 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("# LifeCycleServlet Ŭ������ service() �޼ҵ� ȣ�� #");
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>���� �����ֱ�</h1>");
		out.println("<hr>");
		out.println("</body>");
		out.println("</html>");		
	}

	//destroy() : ���� �ν��Ͻ��� �Ҹ�Ǳ� ���� �����̳ʿ�
	//���� �ѹ��� �ڵ� ȣ��Ǵ� �޼ҵ�
	@Override
	public void destroy() {
		System.out.println("# LifeCycleServlet Ŭ������ destroy() �޼ҵ� ȣ�� #");
	}
}




