<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달값을 이용한 응답문서로 제어권 이동 --%>
<%
	//전달값을 반환받아 저장
	String category=request.getParameter("category");

	//비정상적인 요청에 대한 응답 처리
	if(category==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	//전달값을 이용하여 제어권이 이동될 JSP 문서명을 저장
	String forwardFile=category+".jsp";
%>
<%-- 스레드 이동(제어권 이동) --%>
<jsp:forward page="<%=forwardFile%>"/>

