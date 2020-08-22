<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(login_form.jsp)에서 입력되어 전달된 아이디와 
비밀번호를 반환받아 로그인 처리(인증)하는 JSP 문서 --%>
<%-- => 인증 실패 : 에러메세지와 아이디를 공유한 후 입력페이지 이동 --%>    
<%-- => 인증 성공 : 인증 정보를 공유하고 환영메세지 응답 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		//response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		//return;
		
		//인스턴스 공유 - Session Scope
		session.setAttribute("message", "비정상적인 방법으로 문서를 요청 하였습니다.");
		response.sendRedirect("login_form.jsp");
		return;
	}

	//입력페이지의 전달값을 반환받아 저장
	String id=request.getParameter("id");
	String passwd=request.getParameter("passwd");
	
	//인증 작업 : 아이디와 비밀번호 확인
	if(!id.equals("abc123") || !passwd.equals("123456")) {//인증 실패
		session.setAttribute("message", "아이디 또는 비밀번호가 맞지 않습니다.");
		session.setAttribute("id", id);	
		response.sendRedirect("login_form.jsp");
		return;
	}
	
	//인증 성공 => 세션에 인증 관련 정보를 공유
	session.setAttribute("loginId", id);		
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>로그인 성공</h1>
	<hr>
	<p><%=id %>님 환영합니다.&nbsp;&nbsp;
	<a href="logout_action.jsp">로그아웃</a></p>
	<p><a href="login_form.jsp">로그인 입력페이지 이동</a></p>
</body>
</html>

