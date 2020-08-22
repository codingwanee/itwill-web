<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 상태인 경우 회원 상세정보를 응답하는 JSP 문서 --%>
<%-- => 비로그인 상태인 경우 로그인 입력페이지(member_login.jsp)로 이동 --%>
<%-- => [회원정보변경]을 클릭한 경우 회원정보변경을 위한 비밀번호 입력페이지(modify_confirm.jsp)로 이동 --%>
<%-- => [회원탈퇴]를 클릭한 경우 탈퇴를 위한 비밀번호 입력페이지(remove_confirm.jsp)로 이동 --%>
<style type="text/css">
#detail {
	width: 400px;
	margin: 0 auto;
	text-align: left;
}

#member_menu {
	font-size: 1.1em;
}

#member_menu a:hover {
	color: orange;
}
</style>
<%@include file="/site/security/login_status.jspf" %>
<h1>회원상세정보</h1>
<div id="detail">
<ul>
	<li>아이디 = <%=loginMember.getId() %></li>
	<li>이름 = <%=loginMember.getName()%></li>
	<li>이메일 = <%=loginMember.getEmail() %></li>
	<li>전화번호 = <%=loginMember.getMobile() %></li>
	<li>우편번호 = <%=loginMember.getZipcode() %></li>
	<li>기본주소 = <%=loginMember.getAddress1() %></li>
	<li>상세주소 = <%=loginMember.getAddress2() %></li>
	<li>회원 가입 날짜 = <%=loginMember.getJoinDate().substring(0, 19) %></li>
	<li>최종 로그인 날짜 = <%=loginMember.getLastLogin().substring(0, 19) %></li>
</ul>
</div>

<div id="member_menu">
	<a href="javascript:location.href='<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=modify_confirm';">[회원정보변경]</a>&nbsp;&nbsp;
	<a href="javascript:location.href='<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=remove_confirm';">[회원탈퇴]</a>&nbsp;&nbsp;
</div>




