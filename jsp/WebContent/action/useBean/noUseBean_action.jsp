<%@page import="site.itwill.action.Hewon"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(noUseBean_form.jsp)에서 입력되어 전달된 
값을 반환받아 처리 후 응답페이지(noUseBean_display.jsp)로 이동하는 JSP 문서 --%>    
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//리퀘스트 메세지의 POST 전달값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
	
	//전달된 입력값을 반환받아 저장
	String name=request.getParameter("name");
	String phone=request.getParameter("phone");
	String address=request.getParameter("address");
	
	//DTO 클래스로 인스턴스 생성 후 반환값을 이용하여 필드값 변경
	Hewon hewon=new Hewon();
	hewon.setName(name);
	hewon.setPhone(phone);
	hewon.setAddress(address);

	//DAO 클래스의 메소드 호출하여 처리 - 생략
	
	//Java 코드를 이용한 페이지 이동하는 방법
	
	//1.리다이렉트 이동 : 클라이언트에게 URL 주소를 전달하여 
	//요청을 하도록 하여 다른 JSP 문서로 응답되도록 설정
	// => 클라이언트의 브라우저 URL 주소 변경
	// => session 내장객체를 이용하여 인스턴스를 공유해 사용(Session Scope)
	//session.setAttribute("hewon", hewon);
	//response.sendRedirect("noUseBean_display.jsp");
	
	//2.포워드 이동 : 현재 JSP 문서에서 다른 JSP 문서에 
	//스레드를 이동하여 응답되도록 설정
	// => 클라이언트의 브라우저 URL 주소 미변경
	// => request 내장객체를 이용하여 인스턴스를 공유해 사용(Request Scope)
	request.setAttribute("hewon", hewon);
	//request.getRequestDispatcher(String URL) : 제어권 이동 관련 정보를 
	//저장하는 RequestDispatcher 인스턴스를 반환하는 메소드
	//RequestDispatcher.forward(ServletRequest request, ServletResponse response)
	// => RequestDispatcher 인스턴스에 저장된 JSP 문서로 스레드를 이동하는 메소드
	request.getRequestDispatcher("noUseBean_display.jsp")
		.forward(request, response);
%>




