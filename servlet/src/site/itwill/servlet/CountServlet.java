package site.itwill.servlet;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Ŭ���̾�Ʈ ��û�� ���� ��ûȽ���� Ŭ���̾�Ʈ���� �����ϴ� �����ø����̼�
// => Ŭ���̾�Ʈ�� ���� ��ûȽ���� ī���� ���Ͽ� �����Ͽ� ���
@WebServlet("/count.itwill")
public class CountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//������ ��û Ƚ���� ���� �����ϱ� ���� �ʵ� ����
	// => WAS ����� �ν��Ͻ� �Ҹ� >> �ʵ尪 �Ҹ� - �ʵ尪 ���� �Ұ���
	private int count;
	
	//ī���� ������ �����θ� �����ϱ� ���� �ʵ�
	private String counterFilePath;
	
	//ī���� ���Ͽ� ����� ������ �о� �ʵ忡 ����
	// => ī���� ���Ͽ� ���� ��� �ʵ忡 �ʱⰪ���� 0 ����
	@Override
	public void init(ServletConfig config) throws ServletException {
		//ī���� ������ �����θ� ��ȯ�޾� �ʵ忡 ����
		counterFilePath=config.getServletContext().getRealPath("/WEB-INF/counter.txt");
		//System.out.println("counterFilePath = "+counterFilePath);
		
		try {
			//ī���� ���Ͽ� ���� �Է½�Ʈ���� �����Ͽ� ����
			ObjectInputStream ois=new ObjectInputStream
				(new FileInputStream(counterFilePath));
			
			//���� �Է½�Ʈ���� �̿��Ͽ� ī���� ����(���� ��û Ƚ��)�� ��ȯ�޾� �ʵ忡 ����
			count=(Integer)ois.readObject();
			
			//���� �Է½�Ʈ�� ����
			ois.close();
		} catch (Exception e) {
			count=0;
		}
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//���� ��û Ƚ���� �����ϱ� ���� ����
		// => �޼ҵ� ����Ǹ� �ڵ� �Ҹ�Ǵ� �������� - ������ ���� �Ұ���
		//int count=0;
		//���� ��û Ƚ�� ����
		count++;
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>���� ī��Ʈ</h1>");
		out.println("<hr>");
		out.println("<p>���� ��û Ƚ�� = "+count+"</p>");
		out.println("</body>");
		out.println("</html>");	
	}

	//�ʵ尪(���� ��û Ƚ��)�� ī���� ���Ͽ� ����(������)
	// => ī���� ������ �������� ���� ��� ���� �����Ͽ� �ʵ尪 ���� 
	@Override
	public void destroy() {
		try {
			//ī���� ���Ͽ� ���� ��½�Ʈ���� �����Ͽ� ����
			ObjectOutputStream oos=new ObjectOutputStream
				(new FileOutputStream(counterFilePath));
			
			//����  ��½�Ʈ���� �̿��Ͽ� ī���� ����(���� ��û Ƚ��)�� ���Ͽ� ����
			oos.writeObject(count);

			//���� ��½�Ʈ�� ����
			oos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
