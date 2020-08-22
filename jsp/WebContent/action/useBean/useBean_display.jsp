<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 처리페이지(noUseBean_action.jsp)에서 공유된 
인스턴스를 반환받아 응답하는 JSP 문서 --%>   
<%
	//비정상적 요청에 대한 응답 처리
	if(request.getAttribute("hewon")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
%> 
<jsp:useBean id="hewon" class="site.itwill.action.Hewon" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>회원정보 확인</h1>
	<hr>
	<ul>
		<!-- getProperty 태그의 기능 -->
		<!-- => useBean 태그로 생성된 인스턴스의 필드값을 반환하는 기능을 제공 -->
		<!-- => 인스턴스에 저장된 필드값을 Getter 메소드를 호출하여 반환 -->
		<%-- name 속성 : useBean 태그의 id 속성값을 이용하여 속성값으로 설정 --%>
		<%-- property 속성 : 인스턴스의 필드명을 속성값으로 설정 --%>	
		<li>이름 = <jsp:getProperty name="hewon" property="name"/></li>
		<li>전화번호 = <jsp:getProperty name="hewon" property="phone"/></li>
		<li>주소 = <jsp:getProperty name="hewon" property="address"/></li>
	</ul>
</body>
</html>