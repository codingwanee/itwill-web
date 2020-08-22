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

//오늘 날짜의 공지사항 파일을 읽어 응답문서를 생성하여 클라이언트에서 전달하는 서블릿
// => 오늘 날짜의 공지사항 파일이 없는 경우 공지사항이 없음을 알리는 메세지를 전달
// => 공지사항 파일은 년월일을 이용하여 작성 => ex) 20190701.txt
@WebServlet("/notice.itwill")
public class NoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();

		//날짜 정보를 이용해여 공지사항 파일을 생성하여 저장
		String noticeFile=new SimpleDateFormat
			("yyyyMMdd").format(new Date())+".txt";
		
		//공지사항 파일의 절대경로를 반환받아 저장
		String noticeFilePath=request.getServletContext()
			.getRealPath("/WEB-INF/notice/"+noticeFile);
		//System.out.println("noticeFilePath = "+noticeFilePath);
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1 style='text-align:center;'>공지사항</h1>");
		out.println("<hr>");
		String title=new SimpleDateFormat("yyyy년 MM월 dd일").format(new Date());
		out.println("<p style='text-align:center;'>["+title+"의 공지사항]</p>");
		
		try {
			//공지사항 파일에 대한 입력스트림을 생성
			// => 공지사항 파일이 없는 경우 FileNotFoundException 예외 발생
			BufferedReader br=new BufferedReader(new FileReader(noticeFilePath));
			
			//공지사항 파일에서 공지사항을 읽어 응답문서에 전달
			out.println("<p>");
			while(true) {
				//공지사항 파일에서 한 줄을 읽어와 저장
				String str=br.readLine();
				if(str==null) break;
				if(str.equals("")) str="&nbsp;";
				out.println("<div>"+str+"</div>");
			}
			out.println("</p>");
			
			//파일 입력스트림 제거
			br.close();
		} catch (FileNotFoundException e) {
			out.println("<p>오늘은 공지사항이 없습니다.</p>");
		}
		out.println("<br>");
		out.println("<div style='text-align:center;'><button type='button' onclick='window.close();'>닫기</button></div>");
		out.println("</body>");
		out.println("</html>");
	}

}
