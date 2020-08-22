<%@page import="site.itwill.dao.AjaxMemberDAO"%>
<%@page import="site.itwill.dto.AjaxMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(member_join.jsp)에서 회원정보를 전달받아 AJAX_MEMBER 테이블에
저장하고 출력페이지(member_join_success.jsp)로 이동하는 JSP 문서 --%>    
<%
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;		
	}	

	request.setCharacterEncoding("UTF-8");
	
	String id=request.getParameter("id");
	String passwd=request.getParameter("passwd");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	
	AjaxMemberDTO ajaxMember=new AjaxMemberDTO();
	ajaxMember.setId(id);
	ajaxMember.setPasswd(passwd);
	ajaxMember.setName(name);
	ajaxMember.setEmail(email);
	
	AjaxMemberDAO.getDAO().addAjaxMember(ajaxMember);
	
	response.sendRedirect("member_join_success.jsp");
%>



