<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	//QueryString으로 전달된 값을 반환받아 저장
	String category=request.getParameter("category");
	if(category==null) category="main";
	
	//Header 영역에 포함될 파일을 저장하기 위한 변수 선언
	String headerFile="";
	
	//Footer 영역에 전달된 관리자 정보를 저장하기 위한 변수 선언
	String master="";
	
	//전달값에 따른 Header 영역에 포함될 JSP 문서 설정
	if(category.equals("main")) {
		headerFile="header_main.jsp";
		master="홍길동(abc@google.com)";
	} else if(category.equals("blog")) {
		headerFile="header_blog.jsp";
		master="임꺽정(dfg@itwill.site)";
	} else if(category.equals("cafe")) {
		headerFile="header_cafe.jsp";
		master="전우치(xyz@daum.net)";
	} else {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>include Action Tag</h1>
	<hr>
	<p>현재 JSP 문서에 다른 JSP 문서의 응답을 포함하는 태그
	- 현재 JSP 문서에서 다른 JSP 문서로 스레드 이동(제어권 이동)</p>
	<p>형식) &lt;jsp:include page="JSP 문서명"&gt;&lt;/jsp:include&gt;</p>
	<p>page 속성값의 JSP 문서가 존재하지 않을 경우 에러 발생</p>
	<hr>
	
	<%-- Header 영역 --%>
	<%-- 
	<h2>메인 사이트</h2>
	<a href="include_main.jsp?category=main">메인 사이트</a>&nbsp;&nbsp;	
	<a href="include_main.jsp?category=blog">블로그 사이트</a>&nbsp;&nbsp;	
	<a href="include_main.jsp?category=cafe">카페 사이트</a>
	<hr>
	--%>
	
	<%-- include Directive : 외부 파일(jspf)의 코드 포함 --%>
	<%-- => JSP 문서에 외부 파일의 코드를 포함하여 하나의 문서로 페이지 구현 --%>
	<%-- => JSP 문서와 외부 파일이 값을 전달하여 공유하여 사용 불필요 --%>
	<%-- => 외부 파일이 변경될 경우 JSP 문서는 재컴파일 되어 응답 처리 --%>
	<%-- => file 속성의 속성값으로 표현식 사용 불가능 - 정적포함 --%>
	<%-- <%@include file="header.jspf" %> --%>
	
	<%-- include ActionTag : JSP 문서의 응답 결과 포함 --%>
	<%-- <jsp:include page="header_main.jsp"></jsp:include> --%>
	<%-- => 제어권을 이동하여 실행된 JSP 문서의 결과를 포함하여 두개 이상의 문서로 페이지 구현 --%>
	<%-- => 현재 JSP 문서와 제어권이 이동된 JSP 문서는 값을 전달하거나 공유하여 사용 가능 --%>
	<%-- => 제어권이 이동된 JSP 문서가 변경될 경우 현재 JSP 문서는 미영향 --%>
	<%-- => page 속성값으로 표현식 사용 가능 - 동적포함 --%>
	<%-- <jsp:include page="header_main.jsp"/> --%>
	<jsp:include page="<%=headerFile %>"/>

	<%-- Content 영역 --%>
	<ul>
		<li>요청에 대한 응답 결과 출력</li>
		<li>요청에 대한 응답 결과 출력</li>
		<li>요청에 대한 응답 결과 출력</li>
		<li>요청에 대한 응답 결과 출력</li>
		<li>요청에 대한 응답 결과 출력</li>
	</ul>
	
	<%-- Footer 영역 --%>
	<%-- 
	<hr>
	<p>Copyright ⓒ itwill Corp. All rights reserved.</p>
	<p>관리자 : 홍길동(abc@google.com)</p>
	--%>
	<%-- <jsp:include page="footer.jsp"/> --%>
	
	<%-- param ActionTag : 제어권이 이동되는 JSP 문서에 값(문자열)을 전달하기 위한 태그 --%>
	<%-- => form 태그의 POST 요청과 동일하게 리퀘스트 메세지로 값을 전달 --%>
	<%-- => include ActionTag 또는 forward ActionTag의 하위태그로 사용 --%>
	<jsp:include page="footer.jsp">
		<jsp:param value="<%=master %>" name="master"/>
	</jsp:include>	
</body>
</html>