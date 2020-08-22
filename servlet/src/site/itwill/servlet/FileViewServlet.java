package site.itwill.servlet;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//입력페이지에서 전달된 입력값과 입력파일을 반환받아 
//클라이언트에게 응답문서로 전달하는 서블릿
@WebServlet("/view.itwill")
public class FileViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//비정상적인 요청에 대한 처리 - 에러코드 전달 또는 에러페이지 이동
		if(request.getMethod().equals("GET")) {
			response.sendRedirect("file_view.html");
			return;
		}
		
		//리퀘스트 메세지에 대한 캐릭터셋 변경
		request.setCharacterEncoding("UTF-8");
		
		//입력 전달값(올린이)을 반환받아 저장
		//form 태그의 enctype 속성의 속성값으로 "multipart/form-data"로 설정한 
		//경우 모든 입력값 및 입력파일을 하나의 통합된 형태의 원시데이타로 전달
		// => 입력값을 개별적으로 반환받아 사용 불가능
		String name=request.getParameter("name");
		
		//응답문서를 생성하여 클라이언트에게 전달
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>입력값 및 입력파일 내용 확인</h1>");
		out.println("<hr>");
		out.println("<p>올린이 = "+name+"</p>");
		out.println("<hr>");
		//form 태그의 enctype 속성의 속성값으로 "multipart/form-data"로 설정된 
		//경우 모든 입력값 및 입력파일을 제공받을 수 있는 입력스트림을 반환받아 저장
		//HttpServletRequest.getInputStream() 
		// => 리퀘스트 메세지의 원시데이타를 읽기 위한 입력스트림
		//    (ServletInputStream 인스턴스)을 반환하는 메소드
		//ServletInputStream in=request.getInputStream();
		InputStreamReader in=new InputStreamReader
				(request.getInputStream(), "UTF-8");
		
		//입력스트림에서 읽어들인 데이타를 클라이언트의 응답문서로 전달
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





