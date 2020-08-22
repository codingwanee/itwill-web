<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>JSP 기본객체</h1>
	<hr>
	<p>JSP 문서에 기본적으로 제공되는 인스턴스</p>
	<hr>
	<ul>
		<li>page : JSP 문서에 대한 서블릿 인스턴스 저장하여 제공 - this 키워드와 유사</li>
		<li>config : JSP 문서에 컨텍스트 정보를 저장하여 제공 - web.xml 파일의 저장값을 제공받기 위해 사용</li>
		<li>out : JSP 문서에 포함될 값을 전달하기 위한 출력스트림을 저장하여 제공</li>
		<li>requset : JSP 문서에 클라이언트의 요청정보(리퀘스트 메세지)를 저장하여 제공</li>
		<li>response : JSP 문서에 클라이언트의 응답정보(리스폰즈 메세지)를  저장하여 제공</li>
		<li>session : JSP 문서에 클라이언트와의 연결 지속성 관련 정보를 저장하여 제공</li>
		<li>application : JSP 문서에 WAS(Web Application Server) 정보를 저장하여 제공</li>
		<li>pageContext : JSP 문서에 대한 모든 정보를 저장하여 제공 - 기본객체 제공</li>
		<li>exception : JSP 문서에 다른 문서의 예외정보를 저장하여 제공 - page 디렉티브의 isErrorPage 속성값이 true인 경우에만 제공</li>
	</ul>
</body>
</html>