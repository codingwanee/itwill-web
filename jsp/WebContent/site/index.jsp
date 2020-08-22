<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 템플릿 페이지 --%>    
<%
	request.setCharacterEncoding("UTF-8");	

	String workgroup=request.getParameter("workgroup");
	if(workgroup==null) workgroup="product";
	
	String work=request.getParameter("work");
	if(work==null) work="product_list";
	
	String header="header.jsp";
	if(workgroup.equals("admin")) {
		header="admin/header.jsp";
	}
	
	String contentPath=workgroup+"/"+work+".jsp";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- Header 영역 : 회사로고,메뉴,슬라이더등 --%>
	<div id="header">
		<%-- <jsp:include page="header.jsp"/> --%>
		<jsp:include page="<%=header %>"/>
	</div>
	
	<%-- Content 영역 : 요청에 대한 결과 출력 --%>
	<div id="content">
		<jsp:include page="<%=contentPath %>"/>		
	</div>
	
	<%-- Footer 영역 : 저작권,약관,개인정보 보호정책,회사주소등 --%>
	<% if(!workgroup.equals("admin")) { %>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
	<% } %>
</body>
</html>