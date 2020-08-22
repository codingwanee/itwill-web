<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(useBean_form.jsp)에서 입력되어 전달된 
값을 반환받아 처리 후 응답페이지(useBean_display.jsp)로 이동하는 JSP 문서 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//리퀘스트 메세지의 POST 전달값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
%>

<%-- useBean 태그의 기능 --%>
<%-- => 공유 인스턴스를 반환받아 저장하는 기능을 제공 --%>
<%-- => 인스턴스를 생성하여 공유하는 기능을 제공 --%>
<%-- id 속성(필수) : 참조변수명과 공유속성명으로 사용될 이름을 속성값으로 설정 --%>
<%-- class 속성(필수) : 인스턴스를 생성하기 위한 클래스를 속성값으로 설정 --%>
<%-- scope 속성(선택) : 공유 인스턴스의 범위를 속성값으로 설정 - page(기본), requset, session, application --%>
<jsp:useBean id="hewon" class="site.itwill.action.Hewon" scope="request"/>

<!-- setProperty 태그의 기능 -->
<!-- => useBean 태그로 생성된 인스턴스의 필드값을 변경하는 기능을 제공 -->
<!-- => 입력페이지에서 전달된 값을 반환받아 Setter 메소드를 호출하여 필드값 변경 -->
<!-- 입력태그의 name 속성값과 클래스의 필드명이 같아야만 setProperty 태그 사용 가능 -->
<%-- name 속성 : useBean 태그의 id 속성값을 이용하여 속성값으로 설정 --%>
<%-- property 속성 : 인스턴스의 필드명을 속성값으로 설정 --%>
<%-- 
<jsp:setProperty name="hewon" property="name"/>
<jsp:setProperty name="hewon" property="phone"/>
<jsp:setProperty name="hewon" property="address"/>
--%>
<%-- property 속성값으로 "*"를 설정한 경우 모든 입력값을 반환받아 필드값 변경 --%>
<jsp:setProperty name="hewon" property="*"/>

<jsp:forward page="useBean_display.jsp"/>





