<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그아웃 처리하고 메인페이지(product_list.jsp) 이동 --%>
<%
	//로그아웃 처리 - 세션 초기화
	session.invalidate();

	//메인페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=product&work=product_list");
%>