<%@page import="site.itwill.dao.MemberDAO"%>
<%@page import="site.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보 변경 입력페이지(member_modify.jsp)에서 입력되어 전달된 값을 반환받아
MEMBER 테이블에 저장된 회원정보를 변경하고 회원정보 상세 출력페이지(member_detail.jsp)로 이동하는 JSP 문서 --%>
<%@include file="/site/security/login_status.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//POST 방식의 입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
	
	//입력값을 반환받아 저장
	String id=request.getParameter("id");
	String passwd=request.getParameter("passwd");
	//비밀번호가 입력되어 전달된 경우 - 새로운 비밀번호 사용
	if(passwd!=null && !passwd.equals("")) {
		passwd=Utility.encrypt(request.getParameter("passwd"),"SHA-256");
	} else {//비밀번호가 입력되지 않은 경우 - 기존 비밀번호 사용
		passwd=loginMember.getPasswd();		
	}
	
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String mobile=request.getParameter("mobile1")+"-"
		+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
	String zipcode=request.getParameter("zipcode");
	String address1=request.getParameter("address1");
	String address2=request.getParameter("address2");
	
	//DTO 인스턴스를 생성하고 입력값으로 필드값 변경
	MemberDTO member=new MemberDTO();
	member.setId(id);
	member.setPasswd(passwd);
	member.setName(name);
	member.setEmail(email);
	member.setMobile(mobile);
	member.setZipcode(zipcode);
	member.setAddress1(address1);
	member.setAddress2(address2);
	
	//회원정보를 전달하여 MEMBER 테이블에 저장된 회원정보를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().modifyMember(member);
	
	//변경된 회원정보를 이용하여 세션에 인증정보(회원정보) 재공유
	session.setAttribute("loginMember", MemberDAO.getDAO().getMember(id));	
	
	//회원정보 상세 출력페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=member&work=member_detail");
%>