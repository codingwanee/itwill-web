<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(form.jsp)에서 입력되어 전달된 회원정보를 출력하는 JSP 문서 --%>
<%
	//비정상적인 요청에 대한 응답처리
	// => 입력페이지에서 JSP 문서를 POST 방식으로 요청하지 않은 경우
	//request.getMethod() : 클라이언트의 요청방식을 반환하는 메소드
	if(request.getMethod().equals("GET")) {
		//response.sendError(int statusCode) : 클라이언트에 상태코드(에러코드)를 전달하는 메소드
		//response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		
		//URL 주소에는 영문자, 숫자, 일부 특수문자로만 표현 가능
		// => 영문자, 숫자, 일부 특수문자외 문자는 기본적으로 표현 불가능
		// => 영문자, 숫자, 일부 특수문자외 문자는 부호화 변환하여 표현 가능
		//String message="비정상적인 방법으로 요청 하였습니다.";
		//URLEncoder.encode(String URL, String encoding)
		// => URL 주소로 인식되지 않는 문자를 부호화 변환하여 반환하는 메소드
		String message=URLEncoder.encode("비정상적인 방법으로 요청 하였습니다.","UTF-8");
		
		//response.sendRedirect(String url) : 클라이언트에게 상태코드 301과 URL 주소를 전달하는 메소드
		// => 301 상태코드에 의해 클라이언트는 전달된 URL 주소로 요청 - 리다이렉트 페이지 이동
		//요청 URL 주소에 QueryString를 이용하여 요청문서에 값 전달
		response.sendRedirect("form.jsp?message="+message);
		return;
	}
	
	//request.setCharacterEncoding(String encoding)
	// => 리퀘스트 메세지의 바디영역에 저장되어 전달된 값을 반환받기
	//    위해 인코딩에 대한 캐릭터셋을 변경하는 메소드
	request.setCharacterEncoding("UTF-8");
	
	//입력페이지에서 전달된 값을 반환받아 저장
	//request.getParameter(String parameterName)
	// => 입력태그의 name 속성값(QueryString의 변수값)에 의해 전달된 값을 반환하는 메소드 - 문자열 반환
	// => name 속성값에 의해 전달된 값이 없는 경우 null 반환
	//request.getParameterValues(String parameterName)
	// => 입력태그의 동일 name 속성값에 의해 전달된 값들을 반환하는 메소드 - 문자열 배열 반환
	String id=request.getParameter("id");
	String pass=request.getParameter("pass");
	String name=request.getParameter("name");
	String addr=request.getParameter("addr");
	String sex=request.getParameter("sex");
	String job=request.getParameter("job");
	String[] hobby=request.getParameterValues("hobby");
	String profile=request.getParameter("profile");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>회원가입확인</h1>
	<hr>
	<ul>
		<li>아이디 = <%=id %></li>
		<li>비밀번호 = <%=pass %></li>
		<li>이름 = <%=name %></li>
		<li>주소 = <%=addr %></li>
		<li>성별 = <%=sex %></li>
		<li>직업 = <%=job %></li>
		<% if(hobby==null) { %>
		<li>취미 = 선택하신 취미가 없습니다.</li>
		<% } else { %>
		<li>취미 = 
			<% for(String temp:hobby) { %>
				<%=temp %>&nbsp;
			<% } %>
		</li>
		<% } %>
		<li>자기소개<br><%=profile.replace("\n", "<br>") %></li>
	</ul>
</body>
</html>