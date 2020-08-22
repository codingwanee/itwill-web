<%@page import="site.itwill.util.Utility"%>
<%@page import="site.itwill.dao.MemberDAO"%>
<%@page import="site.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보 입력페이지(member_join.jsp)에서 입력되어 전달된 값을 반환받아
MEMBER 테이블에 저장하고 로그인 입력페이지(member_login.jsp)로 이동하는 JSP 문서 --%>
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
	//String passwd=request.getParameter("passwd");
	//입력받은 비밀번호를 암호화 변환하여 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"),"SHA-256");
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
	
	//회원정보를 전달하여 MEMBER 테이블에 저장하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().addMember(member);
	
	//로그인 입력페이지 이동
	// => 클라이언트에 전달되는 URL 주소는 컨텍스트 경로를 포함한 절대경로로 표현하는 것을 권장
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=member&work=member_login");
%>





