<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>인스턴스 사용범위(Scope)</h1>
	<hr>
	<p>WAS(Web Application Server)에 의해 생명주기가 
	관리되는 인스턴스로 필요한 정보를 공유하여 
	컨텍스트의 특정 웹 어플리케이션에서 사용하는 기능</p>
	<hr>
	<p>Page Scope : JSP 문서의 pageContext 인스턴스(PageContext 클래스)를 이용하여 정보 공유
	- 공유한 JSP 문서에서만 공유된 정보를 반환받아 사용</p> 
	<p>Request Scope : JSP 문서의 request 인스턴스(HttpServletRequest 클래스)를 이용하여 정보 공유
	- 공유한 JSP 문서와 제어권이 이동된 JSP 문서에서 공유된 정보를 반환받아 사용</p> 
	<p>Session Scope : JSP 문서의 session 인스턴스(HttpSession 클래스)를 이용하여 정보 공유
	- 컨텍스트의 모든 문서에서 공유된 정보를 반환받아 사용(클라이언트마다 다른 정보 공유하여 제공)</p>
	<p>Application Scope : JSP 문서의 application 인스턴스(ServletContext 클래스)를 이용하여 정보 공유
	- 컨텍스트의 모든 문서에서 공유된 정보를 반환받아 사용(클라이언트마다 동일 정보 공유하여 제공)</p> 
</body>
</html>






