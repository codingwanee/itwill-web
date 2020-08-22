<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//내장객체를 이용한 정보(인스턴스) 공유
	pageContext.setAttribute("pageName", "홍길동");//Page Scope
	request.setAttribute("requestName", "임꺽정");//Request Scope
	session.setAttribute("sessionName", "전우치");//Session Scope
	application.setAttribute("applicationName", "일지매");//Application Scope
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
	<p>ScopeInstance.setAttribute(String attributeName,Object attributeValue)
	: JSP 문서의 내장객체를 이용하여 정보(인스턴스)를 공유하는 메소드<br>
	- 공유속성명으로 인스턴스를 공유(공유속성명이 존재할 경우 공유 인스턴스 변경)</p>
	<p>ScopeInstance.getAttribute(String attributeName)
	: JSP 문서의 내장객체를 이용하여 공유된 정보(인스턴스)를 반환하는 메소드<br>
	- 공유속성명의 공유 인스턴스가 존재하지 않을 경우 null 반환
	(공유 인스턴스를 Object 클래스 타입으로 반환하므로 객체 형변환하여 사용)</p>
	<hr>
	<%
		//내장객체를 이용한 공유정보(인스턴스) 반환받아 저장
		String pageName=(String)pageContext.getAttribute("pageName");
		String requestName=(String)request.getAttribute("requestName");
		String sessionName=(String)session.getAttribute("sessionName");
		String applicationName=(String)application.getAttribute("applicationName");
	%>
	<ul>
		<li>pageName = <%=pageName %></li>
		<li>requestName = <%=requestName %></li>
		<li>sessionName = <%=sessionName %></li>
		<li>applicationName = <%=applicationName %></li>
	</ul>
	<hr>
	<a href="instance_use.jsp">공유 인스턴스 사용</a>
</body>
</html>



