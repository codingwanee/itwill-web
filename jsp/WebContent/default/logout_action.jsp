<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그아웃 처리 후 입력페이지(login_form.jsp)로 이동하는 JSP 문서 --%>
<%-- => 로그아웃 처리 : 세션으로 공유된 인증정보를 제거 --%>    
<%
	//session.removeAttribute("loginId");

	//session.invalidate() : 세션 초기화 메소드 - 세션으로 공유된 모든 인스턴스 제거
	session.invalidate();

	response.sendRedirect("login_form.jsp");
%>