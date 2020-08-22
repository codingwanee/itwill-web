<?xml version="1.0" encoding="UTF-8"?>
<%@page import="site.itwill.dao.SuggestDAO"%>
<%@page import="site.itwill.dto.SuggestDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 키워드를 전달받아 키워드가 포함된 제시어 관련 정보를 SUGGEST 테이블에서
검색하여 XML 텍스트 데이타로 응답하는 JSP 문서 --%>
<%-- => REST(RePresentation State Transfer) : 웹서비스를 이용하여 정보를 제공하는 기능 --%>
<%
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	
	String keyword=request.getParameter("keyword");
	if(keyword==null || keyword.equals("")) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	List<SuggestDTO> suggestList=SuggestDAO.getDAO().getSuggestList(keyword);
%>
<result>
	<% if(suggestList.size()!=0) { %>
	<code>success</code>
	<data><![CDATA[
		[
		<% for(int i=0;i<suggestList.size();i++) { %>
			<% if(i>0) { %>,<% } %>		
			{"word":"<%=suggestList.get(i).getWord()%>","address":"<%=suggestList.get(i).getAddress()%>"}
		<% } %>		
		]
	]]>
	</data>
	<% } else { %>
	<code>empty</code>
	<% } %>
</result>