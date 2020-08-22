<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>page Directive - isErrorPage 속성</h1>
	<hr>
	<p>속성값을 true로 설정한 경우 에러 발생 문서의 예외 정보를
	저장하는 exception 인스턴스를 에러 메세지 문서에 제공하는 속성</p>
	<hr>
	<h3>프로그램 오류</h3>
	<p>프로그램에 예기치 못한 오류가 발생 하였습니다.<br>
	빠른 시일내로 조치하도록 하겠습니다.</p>
	<%-- 에러 메세지 문서를 요청할 경우 NullPointerException 발생 --%>
	<p>예외 메세지 = <%=exception.getMessage() %></p>
</body>
</html>



