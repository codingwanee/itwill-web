<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>표준 액션 태그(Standard Action Tag)</h1>
	<hr>
	<p>Java 코드 대신 사용하기 위해 JSP에서 제공하는 태그</p>
	<ul>
		<li>include 태그 : 현재 JSP 문서에서 다른 JSP 문서로 스레드를
		이동하여 처리 결과를 전달받아 포함하는 기능</li>
		<li>forward 태그 : 현재 JSP 문서에서 다른 JSP 문서로 스레드를
		이동하여 처리 결과를 대신 응답하는 기능</li>
		<li>param 태그 : 현재 JSP 문서의 값(문자열)을 스레드가 이동되는
		JSP 문서로 전달하는 기능 - include 태그 또는 forward 태그의 하위태그</li>
		<li>useBean 태그 : 인스턴스를 생성하여 공유하거나 공유 인스턴스를 반환받아 사용하는 기능</li>
		<li>setProperty 태그 : useBean 태그로 생성된 공유 인스턴스의 필드값을 
		변경하는 기능(Setter 메소드 호출) - useBean 태그의 종속태그</li>		
		<li>getProperty 태그 : useBean 태그로 생성된 공유 인스턴스의 필드값을 반환하는 기능(Getter 메소드 호출) - useBean 태그의 종속태그</li>
		<li>plugin 태그 : Applet 프로그램을 JSP 문서에 포함하는 기능</li>		
	</ul>
</body>
</html>




