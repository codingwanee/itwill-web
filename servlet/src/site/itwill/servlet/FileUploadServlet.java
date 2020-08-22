package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

//�Է����������� ���޵� �Է°��� �Է����ϸ��� ���乮���� �����Ͽ� Ŭ���̾�Ʈ���� �����ϴ� ����
// => ���޵� �Է������� ���� ���丮�� ���� - ���� ���ε�
//�Է°��� �Է������� ó���ϱ� ���ؼ��� �ܺ� ���̺귯�� ���Ͽ� ����� Ŭ������ ���
// => Apache �׷쿡�� �����ϴ� commons fileUpload ���̺귯���� Ŭ���� ��� - ������ ���� ���ε� 
// => Oreilly �׷쿡�� �����ϴ� cos ���̺귯���� Ŭ���� ��� - �������� ���� ���ε�

//cos ���̺귯���� �ٿ�ε� �޾� ������Ʈ�� ����(Build) ó���ϴ� ���
//1.http://www.servlets.com >> com.oreilly.servlet Ŭ��
//  >> cos-20.08.zip �ٿ�ε�
//2.cos-20.08.zip >> ����Ǯ�� >> lib >> cos.jar(cos ���̺귯��)
//3.cos.jar >> ������Ʈ >> WebContent/WEB-INF/lib ������ �ٿ��ֱ� - ���̺귯�� ���� �ڵ� ����
@WebServlet("/upload.itwill")
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//���������� ��û�� ���� ó�� - �����ڵ� ���� �Ǵ� ���������� �̵�
		if(request.getMethod().equals("GET")) {
			response.sendRedirect("file_upload.html");
			return;
		}
		
		//�Է������� �����ϱ� ���� ���� ���丮�� �����θ� ��ȯ�޾� ����
		// => �۾� ���丮(Workspace)�� �ƴ� �� ���丮(WebApps)�� ��� ��ȯ
		// => �� ���丮�� �Է������� ���ε� �Ǹ� �۾� ���丮�� ���ε� ���� �ʴ´�.(��Ŭ�������� Ȯ�� �Ұ���)
		//������Ʈ�� ���ؽ�Ʈ�� ��ȯ�� �� �۾� ���丮�� ������ �� ���丮�� �ڿ����� �ڵ� ���(����ȭ)
		// => ����ȭ ó���� �� �۾� ���丮�� ������ ���� ��� �� ���丮���� ���� ������(���ε� ���� ����)
		String saveDirectory=request.getServletContext().getRealPath("/upload");
		//System.out.println("saveDirectory = "+saveDirectory);
		
		//MultipartRequest Ŭ���� : �Է°��� �Է������� ó���ϱ� ���� ����� �����ϴ� Ŭ����
		//�����ڸ� �̿��Ͽ� MultipartRequest �ν��Ͻ� ���� - �Է����� ���ε� ó��
		// => HttpServletRequest request : HttpServletRequest �ν��Ͻ� ����(�ʼ�)
		// => String saveDirectory : �Է������� ���ε� �Ǵ� ���� ���丮�� ������ ����(�ʼ�)
		// => int maxPostSize : �ִ� ���� ���� �Է°� �� �Է������� ũ��(Byte)�� ����(����)
		// => String encoding : �Է°��� ���� ĳ���ͼ�(���ڵ� ���) ����(����)
		// => FileRenamePolicy fileRenamePolicy : ���ϸ��� �����ϴ� FileRenamePolicy �ν��Ͻ��� ����(����)
		
		//FileRenamePolicy �ν��Ͻ��� �������� ���� ��� ������ �̸��� ������ ���ε� �ϸ� ���� ���� ��� ���ε� ó��(������)
		// => FileRenamePolicy �ν��Ͻ��� �����ϸ� ������ �̸��� ������ ���ε� �� ��� ���ε� ���ϸ��� �����Ͽ� ���ε� ó�� 
		//FileRenamePolicy �������̽� ��ӹ޴� Ŭ������ �ۼ��Ͽ� ���ϸ� ���� ó��
		// => DefaultFileRenamePolicy Ŭ���� ����Ͽ� ���ϸ� ���� ����
		MultipartRequest mr=new MultipartRequest
			(request, saveDirectory, 30*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
		
		//���޵� �Է°��� ��ȯ�޾� ����
		//MultipartRequest.getParameter(String parameterName)
		// => �Է��±��� name �Ӽ����� �Է°��� ���޹޾� ��ȯ�ϴ� �޼ҵ�
		String name=mr.getParameter("name");
		
		//���޵� �Է����ϸ��� ��ȯ�޾� ����
		//MultipartRequest.getgetOriginalFileName(String parameterName)
		// => �Է��±��� name �Ӽ����� �Է� �������ϸ��� ��ȯ�ϴ� �޼ҵ�
		//String fileone=mr.getOriginalFileName("fileone");
		//String filetwo=mr.getOriginalFileName("filetwo");
		
		//MultipartRequest.getFilesystemName(String parameterName)
		// => �Է��±��� name �Ӽ����� ���� ���ε� ���ϸ��� ��ȯ�ϴ� �޼ҵ�
		String fileone=mr.getFilesystemName("fileone");
		String filetwo=mr.getFilesystemName("filetwo");
		
		//���乮���� �����Ͽ� Ŭ���̾�Ʈ���� ����
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>�Է°� �� �Է����ϸ� Ȯ��</h1>");
		out.println("<hr>");
		out.println("<p>�ø��� = "+name+"</p>");
		out.println("<p>����-1 = "+fileone+"</p>");
		out.println("<p>����-2 = "+filetwo+"</p>");
		out.println("</body>");
		out.println("</html>");	
	}

}
