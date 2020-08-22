<%@page import="site.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디와 상태를 전달받아 MEMBER 테이블에 저장된 회원상태를 변경하고
회원목록 출력페이지(member_list.jsp)로 이동하는 JSP 문서 --%>
<%@include file="../security/admin.jspf" %>
<%
	//전달된 아이디와 상태를 반환받아 저장
	String id=request.getParameter("id");
	int status=Integer.parseInt(request.getParameter("status"));
	
	//아이디와 상태를 전달하여 MEMBER 테이블에 저장된 회원정보 중 상태를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().modifyMemberStatus(id, status);
	
	//회원목록 출력페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=admin&work=member_list");
%>