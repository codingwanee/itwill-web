<?xml version="1.0" encoding="UTF-8"?>
<%@page import="site.itwill.dao.AjaxMemberDAO"%>
<%@page import="site.itwill.dto.AjaxMemberDTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디를 전달받아 AJAX_MEMBER 테이블에서 전달 아이디의 저장유무 
검색하여 XML 텍스트 데이타로 응답하는 JSP 문서 --%>    
<%
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;		
	}

	String id=request.getParameter("id");
	if(id==null || id.equals("")) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	AjaxMemberDTO ajaxMember=AjaxMemberDAO.getDAO().getAjaxMember(id);
%>
<result>
	<% if(ajaxMember==null) { %>
	<code>possible</code>
	<% } else { %>
	<code>impossible</code>
	<% } %>
</result>