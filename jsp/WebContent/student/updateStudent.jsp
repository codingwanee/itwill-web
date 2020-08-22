<%@page import="site.itwill.dao.StudentDAO"%>
<%@page import="site.itwill.dto.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 변경페이지(updateFormStudent.jsp)에서 입력되어 전달된 값을 반환받아 STUDENT 테이블에 
저장된 학생정보를 변경하고 학생목록 응답페이지(displayStudent.jsp)로 이동하는 JSP 문서 --%>        
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		session.setAttribute("message", "비정상적인 방법으로 페이지를 요청 하였습니다.");
		response.sendRedirect("displayStudent.jsp");
		return;
	}	

	//POST 방식의 변경값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
	
	//전달된 변경값을 반환받아 저장
	int no=Integer.parseInt(request.getParameter("no"));
	String name=request.getParameter("name");
	String phone=request.getParameter("phone");
	String address=request.getParameter("address");
	String birthday=request.getParameter("birthday");
	
	//DTO 인스턴스 생성 후 변경값으로 필드값 변경
	StudentDTO student=new StudentDTO();
	student.setNo(no);
	student.setName(name);
	student.setPhone(phone);
	student.setAddress(address);
	student.setBirthday(birthday);	
	
	//학생정보를 전달하여 STUDENT 테이블에 저장된 학생정보를 변경하는 DAO 클래스의 메소드 호출
	StudentDAO.getDAO().modifyStudent(student);
	
	//학생목록 응답페이지(displayStudent.jsp)로 이동
	response.sendRedirect("displayStudent.jsp");	
%>




