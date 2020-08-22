package site.itwill.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import site.itwill.dao.GuestDAO;
import site.itwill.dto.GuestDTO;

//�Է�������(insert.html)���� ���޵� �Է°��� ��ȯ�޾� GUEST ���̺�
//�����ϰ� ���������(select.itwill)�� �̵��ϴ� ���� => ó�������� 
@WebServlet("/insert.itwill")
public class GuestInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//���������� ��û(GET ����� ��û)�� ���� ���� ó�� 
		if(request.getMethod().equals("GET")) {
			//Ŭ���̾�Ʈ���� �����ڵ� 405 ����
			response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return;
		}
		
		//�Է��������� ���ް��� ���� ĳ���ͼ� ����
		request.setCharacterEncoding("UTF-8");
		
		//�Է��������� ���ް��� ��ȯ�޾� ����
		// => ��� �Է°��� ���� �� �Ǵ� ���� ���� ����
		// => XSS ���ݿ� ���� ���� ��ũ��Ʈ ��ȣ�� Escape ���ڷ� ��ȯ
		//XSS ��ŷ : �Է��±׿� ��Ʈ��Ʈ�� �Է��Ͽ� ����Ʈ�� �����ϴ� ��� 
		String name=request.getParameter("name").trim().replace("<", "&lt;").replace(">", "&gt;");
		String email=request.getParameter("email").trim().replace("<", "&lt;").replace(">", "&gt;");
		String homepage=request.getParameter("homepage").trim().replace("<", "&lt;").replace(">", "&gt;");
		String title=request.getParameter("title").trim().replace("<", "&lt;").replace(">", "&gt;");
		String content=request.getParameter("content").trim().replace("<", "&lt;").replace(">", "&gt;");
		
		//DTO Ŭ������ �ν��Ͻ� �����ϰ� �Է°����� �ʵ尪 ����
		GuestDTO guest=new GuestDTO();
		guest.setName(name);
		guest.setEmail(email);
		guest.setHomepage(homepage);
		guest.setTitle(title);
		guest.setContent(content);
		
		//GUEST ���̺� ���� ���� �����ϴ� DAO Ŭ������ �޼ҵ� ȣ��
		GuestDAO.getDAO().addGuest(guest);
		
		//Ŭ���̾�Ʈ���� 301 �ڵ�(������û)�� ��û������
		//URL�� �����Ͽ� ��������� �̵� => �����̷�Ʈ �̵�
		response.sendRedirect("select.itwill");
	}
}