<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 클라이언트의 응답정보를 제공하는 JSP 문서 - 응답페이지 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("part")==null || request.getParameter("work")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	//요청문서(index.jsp)의 전달값을 반환받아 저장
	String part=request.getParameter("part");
	String work=request.getParameter("work");
	
	//전달값을 이용하여 Content 영역에 포함될 JSP 문서의 경로와 파일명 작성
	String contentFilePath="/action/template_site/"+part+"/"+work+".jsp";
	//System.out.println("contentFilePath = "+contentFilePath);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<%-- 
<style type="text/css">
body {
	background: yellow;
}

div {
	margin: 5px;
	padding: 5px;
}

#header {
	height: 140px;
	border: 1px solid black;
}

#header h1 {
	text-align: center;
}

#menu {
	text-align: right;
}

a, a:visited {
	text-decoration: none;
	color: black;
}

a:hover {
	color: aqua;
}

#content {
	min-height: 300px;
	border: 1px solid black;
	text-align: center;
}

#footer {
	height: 100px;
	border: 1px solid black;
	text-align: center;
}
</style>
--%>
<%-- 리소스 파일을 상대경로로 표현할 경우 주의사항 --%>
<%-- template.jsp 파일은 응답 문서이므로 template.jsp 문서를 기준으로 경로 표현할 경우 404 발생 --%>
<%-- <link href="../css/style.css" rel="stylesheet" type="text/css"> --%>
<%-- => index.jsp 파일이 요청 문서이므로 index.jsp 문서를 기준으로 경로 표현 --%>
<%-- <link href="css/style.css" rel="stylesheet" type="text/css"> --%>

<%-- 리소스 파일을 절대경로로 표현하는 것을 권장 --%>
<%-- => 컨텍스트 이름을 변경될 경우 404 발생 --%>
<%-- <link href="/jsp/action/template_site/css/style.css" rel="stylesheet" type="text/css"> --%>
<%-- request.getContextPath() : JSP 문서의 컨텍스트 경로를 반환하는 메소드 --%>
<link href="<%=request.getContextPath()%>/action/template_site/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- Header 영역 --%>
	<div id="header">
		<%-- 
		<h1><a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=product&work=display">쇼핑몰</a></h1>
		<div id="menu">
			<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=product&work=new">신제품</a>&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=product&work=best">추천제품</a>&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=cart&work=display">장바구니</a>&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=order&work=list">구매내역</a>&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=board&work=list">게시판</a>&nbsp;&nbsp;
		</div>
		--%>
		<jsp:include page="header.jsp"/>
	</div>
	
	<%-- Content 영역 --%>
	<div id="content">
		<jsp:include page="<%=contentFilePath %>"/>
	</div>
	
	<%-- Footer 영역 --%>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>





