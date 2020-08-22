package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//�Է�������(join.html)���� �ԷµǾ� ���޵� ���� ��ȯ�޾�
//Ŭ���̾�Ʈ�� ���乮���� �����ϴ� ����� ����
@WebServlet("/join.itwill")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//�Է��������κ��� ���� �Է¹޾� POST ������� ��û���� �ʰ�
		//���� ���� GET ������� ��û�� ��� ���������� ��û
		// => ���������� ��û�� ���� ó�� - �����ڵ� ���� �Ǵ� ���������� �̵� 
		//HttpServletRequest.getMethod() : Ŭ���̾�Ʈ�� ���� ��û����� ��ȯ�ϴ� �޼ҵ�
		if(request.getMethod().equals("GET")) {
			//HttpServletResponse.sendError(int statusCode)
			// => Ŭ���̾�Ʈ���� �����ڵ�(4XX)�� �����ϴ� �޼ҵ�
			//response.sendError(405);
			//HttpServletResponse �������̽������� �����ڵ尡 ����ʵ�(Constant Field)�� ����
			//response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			
			//HttpServletResponse.sendRedirect(URL)
			// => Ŭ���̾�Ʈ���� 301 �����ڵ�� URL �ּҸ� �����ϴ� �޼ҵ�
			// => ���޵� URL �ּҸ� �̿��Ͽ� ���û(301) - ������ �̵�
			// => ���ؽ�Ʈ�� �����ϴ� �ڿ����θ� �̵� ����
			response.sendRedirect("form.html");
			
			return;
		}
		
		//POST ��û����� ������Ʈ �޼��� ���ް��� ���� ĳ���ͼ� ����
		// => ������Ʈ �޼��� ���ް��� �⺻ ĳ���ͼ� : ISO-8859-1(��������)
		//HttpServletRequest.setCharacterEncoding(String encoding)
		// => ������Ʈ �޼��� ���ް��� ���� ĳ���ͼ��� �����ϴ� �޼ҵ�
		request.setCharacterEncoding("UTF-8");		
		
		//�Է��������� �Է� ���ް��� ��ȯ�޾� ����
		//HttpServletRequest.getParameter(String parameterName)
		// => �Է��������� ���ް��� ���ڿ��� ��ȯ�ϴ� �޼ҵ�
		// => �Է��±��� name �Ӽ���(ParameterName)�� �̿��Ͽ� ���ϴ� ���ް��� ��ȯ�޾� ����
		// => �Ķ���͸�� ������ name �Ӽ�����  ���� ��� null ��ȯ
		// => �Է� ���ް��� ���� ��� ���ڿ�(NullString) ��ȯ
		String id=request.getParameter("id");
		//System.out.println("id = "+id);
		
		//���ް��� ���� ��ȿ�� �˻� - ���������� ��û�� ���� ó��
		// => Ŭ���̾�Ʈ(JavaScript)���� ��ȿ�� �˻� �� ����(Java)������ ��ȿ�� �˻�
		if(id==null || id.equals("")) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		Pattern idPattern=Pattern.compile("^[a-zA-Z]\\w{5,19}$");
		if(!idPattern.matcher(id).matches()) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		String pass=request.getParameter("pass");
		
		//���޹��� ��й�ȣ�� ��ȣȭ ��ȯ�Ͽ� ����
		//MessageDigest : ��ȣȭ �˰����� �̿��� ��ȣȭ ����� �����ϴ� Ŭ����
		// => �̱��� Ŭ���� : ���α׷��� �ν��Ͻ��� �ϳ��� ����
		//MessageDigest.getInstance(String algorithm)
		// => ��ȣȭ �˰����� �����Ͽ� MessageDigest �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
		// => NoSuchAlgorithmException �߻� - ����ó��
		//��ȣȭ �˰���(�ܹ���) : MD5, SHA-1, SHA-256(ǥ��), SHA-512 ��
		String encryptPass="";
		try {
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] source)
			// => MessageDigest �ν��Ͻ��� ��ȣȭ �ϰ��� �ϴ� �ҽ��� �����Ͽ� �����ϴ� �޼ҵ�
			// => ��ȣȭ �ϰ��� �ϴ� ���ڿ��� byte �迭(���õ���Ÿ)�� ��ȯ�Ͽ� ����
			//String.getBytes() : String �ν��Ͻ��� byte �迭�� ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
			md.update(pass.getBytes());
			
			//MessageDigest.digest() : MessageDigest �ν��Ͻ���
			//����� byte �迭�� ��ȣȭ ��ȯ�Ͽ� byte �迭�� ��ȯ�ϴ� �޼ҵ�
			byte[] digest=md.digest();
			
			//byte �迭�� String �ν��Ͻ��� ��ȯ�Ͽ� ����
			// => byte �������� ���ʿ䰪 ���� �� 16������ ���ڿ��� ��ȯ�Ͽ� ���ڿ� ����
			for(byte temp:digest) {
				encryptPass+=Integer.toHexString(temp&0xFF);
			}
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String name=request.getParameter("name");
		String addr=request.getParameter("addr");
		String sex=request.getParameter("sex");
		String job=request.getParameter("job");
		//String hobby=request.getParameter("hobby");
		//HttpServletRequest.getParameterValues(String parameterName)
		// => �Է��������� ���ް����� ���ڿ� �迭�� ��ȯ�ϴ� �޼ҵ�
		// => �Է��±��� name �Ӽ����� ������ ��� ���
		String[] hobby=request.getParameterValues("hobby");
		String profile=request.getParameter("profile");
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>ȸ�� �������� Ȯ��</h1>");
		out.println("<hr>");
		out.println("<ul>");
		out.println("<li>���̵� = "+id+"</li>");
		out.println("<li>��й�ȣ = "+pass+"</li>");
		out.println("<li>��й�ȣ(��ȣȭ) = "+encryptPass+"</li>");
		out.println("<li>�̸� = "+name+"</li>");
		out.println("<li>�ּ� = "+addr+"</li>");
		out.println("<li>���� = "+sex+"</li>");
		out.println("<li>���� = "+job+"</li>");
		if(hobby==null || hobby.length==0) {
			out.println("<li>��� = �����Ͻ� ��̰� �ϳ��� �����ϴ�.</li>");
		} else {
			out.println("<li>��� = ");
			for(int i=0;i<hobby.length;i++) {
				out.println(hobby[i]);
				if(i<hobby.length-1) {
					out.println(",");
				}
			}
			out.println("</li>");
		}
		//textarea �±��� �Է� ���ް��� ���͸� <br> �±׷� ��ȯ�Ͽ� ���
		out.println("<li>�ڱ�Ұ�<br>"+profile.replace("\n", "<br>")+"</li>");
		out.println("</ul>");
		out.println("</body>");
		out.println("</html>");	
	}
}



