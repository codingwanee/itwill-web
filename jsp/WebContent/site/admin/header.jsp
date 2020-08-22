<%@page import="site.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 관리자 페이지의 머릿부에 포함될 JSP 문서 --%>
<%-- => 로그인 상태의 관리자만 접근 가능하도록 권한 설정 --%>    
<%
	//세션으로 공유된 인증정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

	if(loginMember==null || loginMember.getStatus()!=9) {
		session.setAttribute("message", "로그인 상태의 관리자만 접근 가능합니다.");
		out.println("<script>");
		out.println("location.href='index.jsp?workgroup=member&work=member_login';");
		out.println("</script>");
		return;
	}
%>    
<div id="profile">
	[<%=loginMember.getName() %>]님 환영합니다.&nbsp;&nbsp;
	<a  href="member/member_logout_action.jsp">로그아웃</a>&nbsp;&nbsp;
	<a  href="index.jsp?workgroup=product&work=product_list">쇼핑몰</a>&nbsp;&nbsp;
</div>
<div id="logo"><a href="index.jsp?workgroup=admin&work=admin_main">사이트관리</a></div>
<div id="menu">
	<a href="index.jsp?workgroup=admin&work=member_list">회원관리</a>
	<a href="index.jsp?workgroup=admin&work=product_list">제품관리</a>
	<a href="index.jsp?workgroup=admin&work=order_list">구매관리</a>
	<a href="index.jsp?workgroup=admin&work=board_list">게시글관리</a>
</div>
