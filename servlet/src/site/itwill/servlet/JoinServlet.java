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

//입력페이지(join.html)에서 입력되어 전달된 값을 반환받아
//클라이언트의 응답문서로 전달하는 기능의 서블릿
@WebServlet("/join.itwill")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//입력페이지로부터 값을 입력받아 POST 방식으로 요청하지 않고
		//직접 서블릿 GET 방식으로 요청한 경우 비정상적인 요청
		// => 비정상적인 요청에 대한 처리 - 에러코드 전달 또는 에러페이지 이동 
		//HttpServletRequest.getMethod() : 클라이언트의 서블릿 요청방식을 반환하는 메소드
		if(request.getMethod().equals("GET")) {
			//HttpServletResponse.sendError(int statusCode)
			// => 클라이언트에게 에러코드(4XX)를 전달하는 메소드
			//response.sendError(405);
			//HttpServletResponse 인터페이스에서는 에러코드가 상수필드(Constant Field)로 제공
			//response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			
			//HttpServletResponse.sendRedirect(URL)
			// => 클라이언트에게 301 상태코드와 URL 주소를 전달하는 메소드
			// => 전달된 URL 주소를 이용하여 재요청(301) - 페이지 이동
			// => 컨텍스트에 존재하는 자원으로만 이동 가능
			response.sendRedirect("form.html");
			
			return;
		}
		
		//POST 요청방식의 리퀘스트 메세지 전달값에 대한 캐릭터셋 변경
		// => 리퀘스트 메세지 전달값의 기본 캐릭터셋 : ISO-8859-1(서유럽어)
		//HttpServletRequest.setCharacterEncoding(String encoding)
		// => 리퀘스트 메세지 전달값에 대한 캐릭터셋을 변경하는 메소드
		request.setCharacterEncoding("UTF-8");		
		
		//입력페이지의 입력 전달값을 반환받아 저장
		//HttpServletRequest.getParameter(String parameterName)
		// => 입력페이지의 전달값을 문자열로 반환하는 메소드
		// => 입력태그의 name 속성값(ParameterName)을 이용하여 원하는 전달값을 반환받아 저장
		// => 파라메터명과 동일한 name 속성값이  없는 경우 null 반환
		// => 입력 전달값이 없는 경우 빈문자열(NullString) 반환
		String id=request.getParameter("id");
		//System.out.println("id = "+id);
		
		//전달값에 대한 유효성 검사 - 비정상적인 요청에 대한 처리
		// => 클라이언트(JavaScript)에서 유효성 검사 후 서버(Java)에서도 유효성 검사
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
		
		//전달받은 비밀번호를 암호화 변환하여 저장
		//MessageDigest : 암호화 알고리즘을 이용한 암호화 기능을 제공하는 클래스
		// => 싱글톤 클래스 : 프로그램에 인스턴스를 하나만 제공
		//MessageDigest.getInstance(String algorithm)
		// => 암호화 알고리즘을 전달하여 MessageDigest 인스턴스를 반환하는 메소드
		// => NoSuchAlgorithmException 발생 - 예외처리
		//암호화 알고리즘(단방향) : MD5, SHA-1, SHA-256(표준), SHA-512 등
		String encryptPass="";
		try {
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] source)
			// => MessageDigest 인스턴스에 암호화 하고자 하는 소스를 전달하여 저장하는 메소드
			// => 암호화 하고자 하는 문자열을 byte 배열(원시데이타)로 변환하여 전달
			//String.getBytes() : String 인스턴스를 byte 배열로 변환하여 반환하는 메소드
			md.update(pass.getBytes());
			
			//MessageDigest.digest() : MessageDigest 인스턴스에
			//저장된 byte 배열을 암호화 변환하여 byte 배열로 반환하는 메소드
			byte[] digest=md.digest();
			
			//byte 배열을 String 인스턴스로 변환하여 저장
			// => byte 정수값의 불필요값 제거 후 16진수의 문자열로 변환하여 문자열 결합
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
		// => 입력페이지의 전달값들을 문자열 배열로 반환하는 메소드
		// => 입력태그의 name 속성값이 동일한 경우 사용
		String[] hobby=request.getParameterValues("hobby");
		String profile=request.getParameter("profile");
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>회원 가입정보 확인</h1>");
		out.println("<hr>");
		out.println("<ul>");
		out.println("<li>아이디 = "+id+"</li>");
		out.println("<li>비밀번호 = "+pass+"</li>");
		out.println("<li>비밀번호(암호화) = "+encryptPass+"</li>");
		out.println("<li>이름 = "+name+"</li>");
		out.println("<li>주소 = "+addr+"</li>");
		out.println("<li>성별 = "+sex+"</li>");
		out.println("<li>직업 = "+job+"</li>");
		if(hobby==null || hobby.length==0) {
			out.println("<li>취미 = 선택하신 취미가 하나도 없습니다.</li>");
		} else {
			out.println("<li>취미 = ");
			for(int i=0;i<hobby.length;i++) {
				out.println(hobby[i]);
				if(i<hobby.length-1) {
					out.println(",");
				}
			}
			out.println("</li>");
		}
		//textarea 태그의 입력 전달값은 엔터를 <br> 태그로 변환하여 출력
		out.println("<li>자기소개<br>"+profile.replace("\n", "<br>")+"</li>");
		out.println("</ul>");
		out.println("</body>");
		out.println("</html>");	
	}
}



