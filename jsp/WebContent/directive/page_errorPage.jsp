<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="page_isErrorPage.jsp"%>
<%
	//String str="ABCDEFG";
	String str=null;
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>page Directive - errorPage 속성</h1>
	<hr>
	<p>JSP 문서에서 예외가 발생된 경우 에러 메세지를 전달하기 위한 문서를 설정하는 속성</p>
	<hr>
	<p>문자열의 문자갯수 = <%=str.length() %></p>
</body>
</html>