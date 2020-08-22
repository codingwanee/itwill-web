<%@page import="site.itwill.dao.MemberDAO"%>
<%@page import="site.itwill.dto.MemberDTO"%>
<%@page import="site.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 입력페이지(member_login.jsp)에서 입력된 값을 전달받아 인증 처리하고 페이지를 이동하는 JSP 문서 --%>
<%-- => 인증 성공 : 세션으로 인증정보를 공유하고 기존 요청페이지 이동 - 기존 요청페이지가 없는 경우 메인페이지(product_list.jsp)로 이동 --%>    
<%-- => 인증 실패 : 세션으로 메세지와 아이디를 공유하고 로그인 입력페이지(member_login.jsp)로 이동 --%>    
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//전달된 입력값을 반환받아 저장
	String id=request.getParameter("id");
	String passwd=Utility.encrypt(request.getParameter("passwd"),"SHA-256");
	
	//아이디를 전달하여 MEMBER 테이블에 저장된 회원정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	MemberDTO member=MemberDAO.getDAO().getMember(id);
	
	//전달된 아이디의 회원정보가 검색되지 않은 경우
	if(member==null) {
		session.setAttribute("message", "입력한 아이디가 존재하지 않습니다.");
		session.setAttribute("id", id);
		response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=member&work=member_login");
		return;
	}
	
	//입력된 비밀번호와 검색된 회원의 비밀번호가 같지 않은 경우
	if(!passwd.equals(member.getPasswd())) {
		session.setAttribute("message", "입력된 아이디 또는 비밀번호가 맞지 않습니다.");
		session.setAttribute("id", id);
		response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=member&work=member_login");
		return;
	}
	
	//아이디를 전달하여 MEMBER 테이블에 저장된 회원정보 중 마지막 로그인 날짜를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().modifyLastLogin(id);
	
	//인증 성공 - 세션을 이용하여 인증정보(회원정보)를 공유
	session.setAttribute("loginMember", MemberDAO.getDAO().getMember(id));
	
	//세션으로 공유된 기존 요청페이지 정보를 반환받아 저장
	String uri=(String)session.getAttribute("uri");
	if(uri==null) {//기존 요청페이지가 없는 경우 - 메인페이지 이동
		response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=product&work=product_list");
	} else {//기존 요청페이지가 있는 경우 - 기존 요청페이지로 이동
		session.removeAttribute("uri");
		response.sendRedirect(uri);
	}
%>






