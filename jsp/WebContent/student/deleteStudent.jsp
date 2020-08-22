<%@page import="site.itwill.dao.StudentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 응답페이지(displayStudent.jsp)에서 학번을 전달받아 STUDENT 테이블에 저장된 
학생정보를 삭제하고 학생목록 응답페이지(displayStudent.jsp)로 이동하는 JSP 문서 --%>    
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("no")==null) {
		session.setAttribute("message", "비정상적인 방법으로 페이지를 요청 하였습니다.");
		response.sendRedirect("displayStudent.jsp");
		return;
	}

	//전달된 학번을 반환받아 저장
	int no=Integer.parseInt(request.getParameter("no"));
	
	//학번을 전달하여 STUDENT 테이블의 저장된 학생정보를 삭제하는 DAO 클래스의 메소드 호출
	int rows=StudentDAO.getDAO().removeStudent(no);

	//삭제행이 존재하지 않을 경우 에러메세지 공유
	if(rows<=0) {
		session.setAttribute("message", "삭제하고자 하는 학번의 학생정보가 존재하지 않습니다.");
	}
	
	response.sendRedirect("displayStudent.jsp");
%>



