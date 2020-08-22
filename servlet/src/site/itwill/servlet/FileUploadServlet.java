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

//입력페이지에서 전달된 입력값과 입력파일명을 응답문서로 생성하여 클라이언트에게 전달하는 서블릿
// => 전달된 입력파일은 서버 디렉토리에 저장 - 파일 업로드
//입력값과 입력파일을 처리하기 위해서는 외부 라이브러리 파일에 선언된 클래스를 사용
// => Apache 그룹에서 제공하는 commons fileUpload 라이브러리의 클래스 사용 - 선택적 파일 업로드 
// => Oreilly 그룹에서 제공하는 cos 라이브러리의 클래스 사용 - 무조건적 파일 업로드

//cos 라이브러리를 다운로드 받아 프로젝트에 빌드(Build) 처리하는 방법
//1.http://www.servlets.com >> com.oreilly.servlet 클릭
//  >> cos-20.08.zip 다운로드
//2.cos-20.08.zip >> 압축풀기 >> lib >> cos.jar(cos 라이브러리)
//3.cos.jar >> 프로젝트 >> WebContent/WEB-INF/lib 폴더에 붙여넣기 - 라이브러리 파일 자동 빌드
@WebServlet("/upload.itwill")
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//비정상적인 요청에 대한 처리 - 에러코드 전달 또는 에러페이지 이동
		if(request.getMethod().equals("GET")) {
			response.sendRedirect("file_upload.html");
			return;
		}
		
		//입력파일을 저장하기 위한 서버 디렉토리의 절대경로를 반환받아 저장
		// => 작업 디렉토리(Workspace)가 아닌 웹 디렉토리(WebApps)에 경로 반환
		// => 웹 디렉토리에 입력파일이 업로드 되며 작업 디렉토리에 업로드 되지 않는다.(이클립스에서 확인 불가능)
		//프로젝트가 컨텍스트로 변환될 때 작업 디렉토리의 파일이 웹 디렉토리의 자원으로 자동 등록(동기화)
		// => 동작화 처리될 때 작업 디렉토리의 파일이 없는 경우 웹 디렉토리에도 파일 미존재(업로드 파일 제거)
		String saveDirectory=request.getServletContext().getRealPath("/upload");
		//System.out.println("saveDirectory = "+saveDirectory);
		
		//MultipartRequest 클래스 : 입력값과 입력파일을 처리하기 위한 기능을 제공하는 클래스
		//생성자를 이용하여 MultipartRequest 인스턴스 생성 - 입력파일 업로드 처리
		// => HttpServletRequest request : HttpServletRequest 인스턴스 전달(필수)
		// => String saveDirectory : 입력파일이 업로드 되는 서버 디렉토리의 절대경로 전달(필수)
		// => int maxPostSize : 최대 전달 가능 입력값 및 입력파일의 크기(Byte)를 전달(선택)
		// => String encoding : 입력값에 대한 캐릭터셋(인코딩 방식) 전달(선택)
		// => FileRenamePolicy fileRenamePolicy : 파일명을 변경하는 FileRenamePolicy 인스턴스를 전달(선택)
		
		//FileRenamePolicy 인스턴스를 전달하지 않은 경우 동일한 이름의 파일을 업로드 하면 기존 파일 대신 업로드 처리(덮어씌우기)
		// => FileRenamePolicy 인스턴스를 전달하면 동일한 이름의 파일을 업로드 할 경우 업로드 파일명을 변경하여 업로드 처리 
		//FileRenamePolicy 인터페이스 상속받는 클래스를 작성하여 파일명 변경 처리
		// => DefaultFileRenamePolicy 클래스 사용하여 파일명 변경 가능
		MultipartRequest mr=new MultipartRequest
			(request, saveDirectory, 30*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
		
		//전달된 입력값을 반환받아 저장
		//MultipartRequest.getParameter(String parameterName)
		// => 입력태그의 name 속성값의 입력값을 전달받아 반환하는 메소드
		String name=mr.getParameter("name");
		
		//전달된 입력파일명을 반환받아 저장
		//MultipartRequest.getgetOriginalFileName(String parameterName)
		// => 입력태그의 name 속성값의 입력 원본파일명을 반환하는 메소드
		//String fileone=mr.getOriginalFileName("fileone");
		//String filetwo=mr.getOriginalFileName("filetwo");
		
		//MultipartRequest.getFilesystemName(String parameterName)
		// => 입력태그의 name 속성값의 실제 업로드 파일명을 반환하는 메소드
		String fileone=mr.getFilesystemName("fileone");
		String filetwo=mr.getFilesystemName("filetwo");
		
		//응답문서를 생성하여 클라이언트에게 전달
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>입력값 및 입력파일명 확인</h1>");
		out.println("<hr>");
		out.println("<p>올린이 = "+name+"</p>");
		out.println("<p>파일-1 = "+fileone+"</p>");
		out.println("<p>파일-2 = "+filetwo+"</p>");
		out.println("</body>");
		out.println("</html>");	
	}

}
