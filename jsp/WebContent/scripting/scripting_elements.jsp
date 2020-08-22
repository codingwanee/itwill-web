<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>스크립팅 요소(Scripting Elements)</h1>
	<hr>
	<p>명령(Scriptlet) : _jspService() 메소드 내부에 Java 명령을 작성하는 영역
	- &lt;% Java 명령; %&gt;</p>
	<p>선언(Declaration) : _jspService() 메소드 외부에 필드 또는 메소드를 선언하는 영역
	- &lt;%! 필드 또는 메소드 선언 %&gt;</p>
	<p>표현(Expression) : Java에서 사용되는 값을 출력하는 영역
	- &lt;%= Java 변수(변수값) 또는 연산식(결과값) 또는 메소드 호출(반환값) %&gt;</p>
</body>
</html>



