<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원탈퇴를 위한 비밀번호를 입력하는 JSP 문서 --%>
<%-- => [입력완료]를 클릭한 경우 회원탈퇴 처리페이지(member_remove_action.jsp)로 이동 --%>
<%@include file="/site/security/login_status.jspf" %>
<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>    
<form name="passwdForm" action="<%=request.getContextPath()%>/site/member/member_remove_action.jsp" 
	method="post" onsubmit="return submitCheck();">
	<p>회원탈퇴를 위한 비밀번호를 입력해 주세요.</p>
	<p>
		<input type="password" name="passwd">
		<button type="submit">입력완료</button>	
	</p>
	<p id="message" style="color: red;"><%=message %></p>
</form>
<script type="text/javascript">
passwdForm.passwd.focus();

function submitCheck() {
	if(passwdForm.passwd.value=="") {
		passwdForm.passwd.focus();
		document.getElementById("message").innerHTML="비밀번호를 입력해 주세요.";
		return false;
	}
	return true;
}
</script>
