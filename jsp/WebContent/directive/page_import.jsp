<%-- <%@page import="java.util.List,java.util.ArrayList" %> --%>
<!-- 이클립스의 자동 완성 기능을 이용하여 자동 import 설정 -->
<!-- page 지시어의 동일 속성의 속성값이 같지 않을 경우 에러 발생 -->
<!-- => import 속성은 속성값이 같지 않아도 에러 미발생 -->
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
	//java.util.List<String> nameList=new java.util.ArrayList<String>();
	List<String> nameList=new ArrayList<String>();
	nameList.add("홍길동");
	nameList.add("임꺽정");
	nameList.add("전우치");
	nameList.add("일지매");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>page Directive - import 속성</h1>
	<hr>
	<p>클래스(인터페이스)를 쉽게 사용할 수 있도록 
	문서에 패키지 형태로 정의하는 속성</p>
	<hr>
	<ul>
	<% for(String name:nameList) { %>
		<li><%=name %></li>
	<% } %>
	</ul>
</body>
</html>
