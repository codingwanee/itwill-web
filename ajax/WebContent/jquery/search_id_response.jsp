<?xml version="1.0" encoding="UTF-8"?>
<%@page import="site.itwill.dao.AjaxMemberDAO"%>
<%@page import="site.itwill.dto.AjaxMemberDTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 이름과 이메일을 전달받아 AJAX_MEMBER 테이블에 저장된 해당 회원의 
아이디를 검색하여 XML 텍스트 데이타로 응답하는 JSP 문서 --%>    
<%
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	String email=request.getParameter("email");

	AjaxMemberDTO ajaxMember=new AjaxMemberDTO();
	ajaxMember.setName(name);
	ajaxMember.setEmail(email);
	
	String id=AjaxMemberDAO.getDAO().getAjaxMemberId(ajaxMember);
%>
<result>
	<% if(id!=null) { %>
	<code>success</code>
	<id><%=id%></id>
	<% } else { %>
	<code>empty</code>
	<% } %>
</result>






