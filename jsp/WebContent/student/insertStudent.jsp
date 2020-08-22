<%@page import="site.itwill.dao.StudentDAO"%>
<%@page import="site.itwill.dto.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(insertFormStudent.jsp)에서 입력되어 전달된 값을 반환받아 STUDENT  
테이블에 저장하고 학생목록 응답페이지(displayStudent.jsp)로 이동하는 JSP 문서 --%>        
<%
	//비정상적인 요청에 대한 응답 처리
	// => 메세지를 공유하여 입력페이지로 이동
	if(request.getMethod().equals("GET")) {
		session.setAttribute("message", "비정상적인 방법으로 페이지를 요청 하였습니다.");
		response.sendRedirect("insertFormStudent.jsp");
		return;
	}
	
	//POST 방식의 입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
	
	//전달된 입력값을 반환받아 저장
	int no=Integer.parseInt(request.getParameter("no"));
	String name=request.getParameter("name");
	String phone=request.getParameter("phone");
	String address=request.getParameter("address");
	String birthday=request.getParameter("birthday");
	
	//DTO 인스턴스 생성 후 입력값으로 필드값 변경
	StudentDTO student=new StudentDTO();
	student.setNo(no);
	student.setName(name);
	student.setPhone(phone);
	student.setAddress(address);
	student.setBirthday(birthday);

	//입력된 학번에 대한 STUDENT 테이블의 저장 유무 확인
	// => 이미 사용중인 학번인 경우 입력페이지(insertFormStudent.jsp)로 이동
	//학번을 전달하여 STUDENT 테이블의 저장된 학생정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	if(StudentDAO.getDAO().getStudent(no)!=null) {
		session.setAttribute("message", "이미 사용중인 학번을 입력 하였습니다.");
		session.setAttribute("student", student);
		response.sendRedirect("insertFormStudent.jsp");
		return;
	}
	 
	//STUDENT 테이블에 학생정보를 전달하여 저장하는 DAO 클래스의 메소드 호출
	StudentDAO.getDAO().addStudent(student);
	
	//학생목록 응답페이지(displayStudent.jsp)로 이동
	response.sendRedirect("displayStudent.jsp");
%>
