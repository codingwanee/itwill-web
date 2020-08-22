package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//서블릿(웹에서 동작되는 어플리케이션) 작성 방법
//1.HttpServlet 클래스를 상속 받아 작성 - 서블릿 클래스
//=> HttpServlet 클래스를 상속 받은 자식 클래스는 객체 직렬화 클래스로
//   serialVersionUID 필드를 선언하는 것을 권장
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//2.doGet() 및 doPost() 메소드를 오버라이드 선언
	// => 클라이언트 요청에 대한 실행과 응답을 위해 자동 호출되는 메소드
	// => doGet() : 클라이언트의 GET 방식 요청에 대한 실행과 응답 메소드
	// => doPost() : 클라이언트의 POST 방식 요청에 대한 실행과 응답 메소드
	// => doGet() 및 doPost() 메소드 대신 service() 메소드 오버라이드 선언 가능
	// => doGet() 및 doPost() 메소드보다 service() 메소드의 호출 순위가 높다.
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//WAS(Web Application Server)에 의해 메소드가 호출될 때 HttpServletRequest 인스턴스와
		//HttpServletResponse 인스턴스가 파라메터에 자동으로 전달되어 저장
		//HttpServletRequest 인스턴스 : 리퀘스트 메세지(요청정보)를 저장하고 있는 인스턴스
		//HttpServletResponse 인스턴스 : 리스폰즈 메세지(응답정보)를 저장하고 있는 인스턴스
	
		//3.클라이언트에게 응답할 문서(파일) 형식(Mime Type) 전달
		// => 문서 형식으로 응답할 경우 문서의 캐릭터셋(Character Encoding) 설정
		// => 기본 응답 문서 형식 : text/html, 캐릭터셋 : ISO-8859-1(서유럽어)
		//기본 응답 문서 형식을 사용하지 않고 원하는 문서 형식으로 전달되도록 변경
		//형식) HttpServletResponse.setContentType(String MimeType[;charset=Encoding])
		// => 응답 문서 형식을 변경하는 메소드 - 캐릭터셋 설정
		response.setContentType("text/html;charset=UTF-8");
		
		//4.클라이언트에게 실행 결과를 전달(응답)하기 위한 출력스트림을 반환받아 저장
		//형식) HttpServletResponse.getOutputStream()
		// => 원시데이타(1Byte)를 전달할 수 있는 출력스트림(ServletOutputStream 인스턴스)을 반환하는 메소드
		// => 그림, 음악, 동영상 파일등을 클라이언트에게 전달하기 위한 사용하는 출력스트림 
		//형식) HttpServletResponse.getWriter()
		// => 문자데이타(2Byte)를 전달할 수 있는 출력스트림(PrintWriter 인스턴스)을 반환하는 메소드
		// => HTML, XML, Word 파일등(텍스트파일 : 문서)을 클라이언트에게 전달하기 위한 사용하는 출력스트림
		PrintWriter out=response.getWriter();
		
		//5.클라이언트 요청에 대한 실행과 응답
		// => 클라이언트의 요청값을 제공받아 처리 후 결과값을 클라이언트에게 전달
	
		//출력스트림의 메소드를 호출하여 클라이언트에게 결과값 전달
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>서블릿(Servlet)</h1>");
		out.println("<hr>");
		out.println("<p>Hello. Servlet!!!</p>");
		out.println("</body>");
		out.println("</html>");
		
		//6.web.xml 파일에 서블릿 클래스를 서블릿으로 등록 후  
		//URL 자원명을 매핑 설정해야만 요청을 받아 응답
	}
}




