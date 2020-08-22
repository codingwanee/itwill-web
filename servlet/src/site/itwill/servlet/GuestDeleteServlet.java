package site.itwill.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import site.itwill.dao.GuestDAO;

//�۹�ȣ�� ���޹޾� GUEST ���̺��� �ش� ���� �����ϰ� ���������(select.itwill)�� �̵��ϴ� ����
@WebServlet("/delete.itwill")
public class GuestDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//���������� ��û(���޵� �۹�ȣ�� ���� ���)�� ���� ���� ó��
		if(request.getParameter("no")==null) {
			//Ŭ���̾�Ʈ���� �����ڵ� 400 ����
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		//���޹��� �۹�ȣ�� ��ȯ�޾� ����
		int no=Integer.parseInt(request.getParameter("no"));
		
		//GUEST ���̺��� ���� �����ϴ� DAO Ŭ������ �޼ҵ� ȣ��
		int rows=GuestDAO.getDAO().removeGuest(no);
	
		if(rows>0) {
			//Ŭ���̾�Ʈ���� 301 �ڵ�(������û)�� ��û������
			//URL�� �����Ͽ� ��������� �̵� => �����̷�Ʈ �̵�
			response.sendRedirect("select.itwill");
		} else {
			//���������� ��û(�������� ���� ���)�� ���� ���� ó��
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		}
		
	}
}



