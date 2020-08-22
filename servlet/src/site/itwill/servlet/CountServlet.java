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

//클라이언트 요청시 서블릿 요청횟수를 클라이언트에게 제공하는 웹어플리케이션
// => 클라이언트의 서블릿 요청횟수를 카운터 파일에 저장하여 사용
@WebServlet("/count.itwill")
public class CountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//서블릿의 요청 횟수를 누적 저장하기 위한 필드 선언
	// => WAS 종료시 인스턴스 소멸 >> 필드값 소멸 - 필드값 유지 불가능
	private int count;
	
	//카운터 파일의 절대경로를 저장하기 위한 필드
	private String counterFilePath;
	
	//카운터 파일에 저장된 정보를 읽어 필드에 저장
	// => 카운터 파일에 없는 경우 필드에 초기값으로 0 저장
	@Override
	public void init(ServletConfig config) throws ServletException {
		//카운터 파일의 절대경로를 반환받아 필드에 저장
		counterFilePath=config.getServletContext().getRealPath("/WEB-INF/counter.txt");
		//System.out.println("counterFilePath = "+counterFilePath);
		
		try {
			//카운터 파일에 대한 입력스트림을 생성하여 저장
			ObjectInputStream ois=new ObjectInputStream
				(new FileInputStream(counterFilePath));
			
			//파일 입력스트림을 이용하여 카운터 정보(서블릿 요청 횟수)를 반환받아 필드에 저장
			count=(Integer)ois.readObject();
			
			//파일 입력스트림 제거
			ois.close();
		} catch (Exception e) {
			count=0;
		}
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//서블릿 요청 횟수를 누적하기 위한 변수
		// => 메소드 종료되면 자동 소멸되는 지역변수 - 변수값 유지 불가능
		//int count=0;
		//서블릿 요청 횟수 누적
		count++;
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>서블릿 카운트</h1>");
		out.println("<hr>");
		out.println("<p>서블릿 요청 횟수 = "+count+"</p>");
		out.println("</body>");
		out.println("</html>");	
	}

	//필드값(서블릿 요청 횟수)을 카운터 파일에 저장(덮어씌우기)
	// => 카운터 파일이 존재하지 않응 경우 파일 생성하여 필드값 저장 
	@Override
	public void destroy() {
		try {
			//카운터 파일에 대한 출력스트림을 생성하여 저장
			ObjectOutputStream oos=new ObjectOutputStream
				(new FileOutputStream(counterFilePath));
			
			//파일  출력스트림을 이용하여 카운터 정보(서블릿 요청 횟수)를 파일에 저장
			oos.writeObject(count);

			//파일 출력스트림 제거
			oos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
