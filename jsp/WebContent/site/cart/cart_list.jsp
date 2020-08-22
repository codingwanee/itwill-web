<%@page import="site.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 장바구니 목록을 응답하는 JSP 문서 --%>    
<%-- => 로그인 상태에서만 접근 가능한 페이지 --%>
<%-- => 비로그인 상태에서 접근할 경우 로그인 입력페이지(member_login.jsp)로 이동 --%>
<%-- => 로그인 성공 후 기존 요청 페이지로 이동 --%>
<%-- 
<%
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(loginMember==null) {
		//request.getRequestURI() : 요청문서의 URI 주소를 반환하는 메소드
		String requestURI=request.getRequestURI();
		//System.out.println("requestURI = "+requestURI);
		
		String queryString=request.getQueryString(); 
		//System.out.println("queryString = "+queryString);
		
		if(queryString==null || queryString.equals("")) {
			queryString="";
		} else {
			queryString="?"+queryString;
		}
		
		//세션으로 기존 요청페이지 공유 
		session.setAttribute("uri", requestURI+queryString);
		session.setAttribute("message", "로그인 사용자가 접근 가능한 페이지입니다.");
		
		//템플릿 페이지에 포함되는 문서에서는 리다렉이트 이동 불가능
		//response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=member&work=member_login");
%>
		<script type="text/javascript">
			location.href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=member_login";
		</script>
<%
		return;
	}
%>
--%>
<%@include file="/site/security/login_status.jspf" %>
<h1>장바구니 목록</h1>




