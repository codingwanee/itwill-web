<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>include Directive</h1>
	<hr>
	<p>외부 파일(컨텍스트 자원)의 코드를 JSP 문서에 포함(정적포함)</p>
	<p>형식) &lt;%@include file="외부파일명"%&gt;</p>
	<p>포함될 외부파일이 존재하지 않을 경우 에러 발생</p>
	<hr>
	<%--
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	<p>클라이언트 요청에 대한 응답 메세지</p>
	--%>
	<%@include file="include_sub.jspf" %>
</body>
</html>






