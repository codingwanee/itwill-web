<%@page import="site.itwill.dao.MemberDAO"%>
<%@page import="site.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 비교하여 회원탈퇴 하고 로그아웃
처리페이지(member_logout_action.jsp)로 이동하는 JSP 문서 --%>    
<%@include file="/site/security/login_status.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//입력된 비밀번호를 반환받아 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"), "SHA-256");
	
	//입력 비밀번호와 로그인 사용자의 비밀번호를 비교하지 맞지 않을 경우 
	if(!passwd.equals(loginMember.getPasswd())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");	
		response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=member&work=remove_confirm");
		return;
	}
	
	//아이디를 전달하여 MEMBER 테이블에 저장된 회원정보를 삭제하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().removeMember(loginMember.getId());	
	
	//로그아웃 처리페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/member/member_logout_action.jsp");
%>



