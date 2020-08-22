<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>지시어(Directives)</h1>
	<hr>
	<p>page Directive : JSP 문서 작성에 필요한 정보를 제공되도록 지시
	- &lt;%@page 속성="속성값" 속성="속성값" ... %&gt;</p>
	<p>include Directive : JSP 문서에 외부 파일의 코드가 포함되도록 지시
	- &lt;%@include file="외부파일명" %&gt;</p>
	<p>taglib Directive : JSP 문서에 Java 코드로 작성된 태그가 선언된 파일을 제공되도록 지시
	- &lt;%@taglib prefix="네임스페이스" uri="파일고유값" %&gt;</p>
</body> 
</html>