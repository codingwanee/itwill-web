<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//내장객체를 이용한 공유정보(인스턴스) 반환받아 저장
	String pageName=(String)pageContext.getAttribute("pageName");
	String requestName=(String)request.getAttribute("requestName");
	String sessionName=(String)session.getAttribute("sessionName");
	String applicationName=(String)application.getAttribute("applicationName");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>인스턴스 공유와 사용범위</h1>
	<hr>
	<ul>
		<li>pageName = <%=pageName %></li>
		<li>requestName = <%=requestName %></li>
		<li>sessionName = <%=sessionName %></li>
		<li>applicationName = <%=applicationName %></li>
	</ul>
</body>
</html>