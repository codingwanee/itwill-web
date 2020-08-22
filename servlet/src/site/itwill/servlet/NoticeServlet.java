package site.itwill.servlet;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//���� ��¥�� �������� ������ �о� ���乮���� �����Ͽ� Ŭ���̾�Ʈ���� �����ϴ� ����
// => ���� ��¥�� �������� ������ ���� ��� ���������� ������ �˸��� �޼����� ����
// => �������� ������ ������� �̿��Ͽ� �ۼ� => ex) 20190701.txt
@WebServlet("/notice.itwill")
public class NoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();

		//��¥ ������ �̿��ؿ� �������� ������ �����Ͽ� ����
		String noticeFile=new SimpleDateFormat
			("yyyyMMdd").format(new Date())+".txt";
		
		//�������� ������ �����θ� ��ȯ�޾� ����
		String noticeFilePath=request.getServletContext()
			.getRealPath("/WEB-INF/notice/"+noticeFile);
		//System.out.println("noticeFilePath = "+noticeFilePath);
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1 style='text-align:center;'>��������</h1>");
		out.println("<hr>");
		String title=new SimpleDateFormat("yyyy�� MM�� dd��").format(new Date());
		out.println("<p style='text-align:center;'>["+title+"�� ��������]</p>");
		
		try {
			//�������� ���Ͽ� ���� �Է½�Ʈ���� ����
			// => �������� ������ ���� ��� FileNotFoundException ���� �߻�
			BufferedReader br=new BufferedReader(new FileReader(noticeFilePath));
			
			//�������� ���Ͽ��� ���������� �о� ���乮���� ����
			out.println("<p>");
			while(true) {
				//�������� ���Ͽ��� �� ���� �о�� ����
				String str=br.readLine();
				if(str==null) break;
				if(str.equals("")) str="&nbsp;";
				out.println("<div>"+str+"</div>");
			}
			out.println("</p>");
			
			//���� �Է½�Ʈ�� ����
			br.close();
		} catch (FileNotFoundException e) {
			out.println("<p>������ ���������� �����ϴ�.</p>");
		}
		out.println("<br>");
		out.println("<div style='text-align:center;'><button type='button' onclick='window.close();'>�ݱ�</button></div>");
		out.println("</body>");
		out.println("</html>");
	}

}
