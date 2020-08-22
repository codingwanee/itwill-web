<%@page import="site.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 상태와 비로그인 상태를 구분하여 다른 응답 결과 제공 --%>
<%
	//세션으로 공유된 인증정보(회원정보)를 반환받아 저장
	// => 반환값 : null - 비로그인 상태
	// => 반환값 : MemberDTO 인스턴스 - 로그인 상태
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
%>    
<div id="profile">
	<% if(loginMember==null) {//비로그인 상태 %>
		<a href="index.jsp?workgroup=member&work=member_login">로그인</a>&nbsp;&nbsp;
		<a href="index.jsp?workgroup=member&work=member_join">회원가입</a>&nbsp;&nbsp;
	<% } else {//로그인 상태 %>
		[<%=loginMember.getName() %>]님 환영합니다.&nbsp;&nbsp;
		<a href="member/member_logout_action.jsp">로그아웃</a>&nbsp;&nbsp;
		<a href="index.jsp?workgroup=member&work=member_detail">내정보</a>&nbsp;&nbsp;
		<% if(loginMember.getStatus()==9) {//관리자 %>
		<a href="index.jsp?workgroup=admin&work=admin_main">관리자</a>&nbsp;&nbsp;
		<% } %>
	<% } %>
</div>
<div id="logo"><a href="index.jsp">쇼핑몰</a></div>
<div id="menu">
	<a href="index.jsp?workgroup=product&work=product_list">제품소개</a>
	<a href="index.jsp?workgroup=cart&work=cart_list">장바구니</a>
	<a href="index.jsp?workgroup=order&work=order_list">구매내역</a>
	<a href="index.jsp?workgroup=board&work=board_list">게시판</a>
</div>