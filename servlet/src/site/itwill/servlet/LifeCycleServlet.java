package site.itwill.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//서블릿은 클라이언트의 요청에 의해 WAS(Web Application Server)의
//컨테이너가 인스턴스를 생성하여 요청 처리 후 응답 문서 제공
// => 요청 자원에 대한 서블릿 인스턴스가 이미 존재할 경우 인스턴스 미생성
// => 서블릿 인스턴스는 WAS 종료시 컨테이너에 의해 소멸
// => 컨테이너는 서블릿 인스턴스의 생성,사용,소멸(생명주기:LifeCycle) 관리(제어) 담당
@WebServlet("/life.itwill")
public class LifeCycleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//생성자(Constructor) : 인스턴스를 생성하는 특별한 메소드
	// => 서블릿 인스턴스 생성시 한번만 호출 : 초기화 작업(필드 초기값 부여)
	public LifeCycleServlet() {
		System.out.println("# LifeCycleServlet 클래스의 기본 생성자 호출 #");
	}
	
	//init() : 서블릿 인스턴스 생성 후 컨테이너에 의해 
	//가장 먼저 자동 호출되는 메소드 - 한번만 호출
	// => 서블릿 인스턴스의 요청 처리 전 초기화 작업
	// => 생성자 대신 init() 메소드로 초기화 작업을 하는 이유는 ServletConfig 인스턴스를 제공 받아 사용
	//ServletConfig : web.xml 파일에 존재하는 정보를 제공받을 수 있는 기능의 인스턴스 
	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("# LifeCycleServlet 클래스의 init() 메소드 호출 #");
	}
	
	//service() : 클라이언트의 요청마다 컨테이너에 의해 자동 호출되는 메소드 
	// => 요청에 대한 처리 후 응답 문서를 생성하여 클라이언트에게 제공
	// => doGet() 및 doPost() 메소드도 유사한 작업을 수행하는 메소드  
	// => 메소드 선언 되어 있지 않은 경우 클라이언트에게 405 응답코드 전달 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("# LifeCycleServlet 클래스의 service() 메소드 호출 #");
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>서블릿 생명주기</h1>");
		out.println("<hr>");
		out.println("</body>");
		out.println("</html>");		
	}

	//destroy() : 서블릿 인스턴스를 소멸되기 전에 컨테이너에
	//의해 한번만 자동 호출되는 메소드
	@Override
	public void destroy() {
		System.out.println("# LifeCycleServlet 클래스의 destroy() 메소드 호출 #");
	}
}




