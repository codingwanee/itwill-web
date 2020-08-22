<%@page import="site.itwill.dao.StudentDAO"%>
<%@page import="site.itwill.dto.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 응답페이지(displayStudent.jsp)에서 학번을 전달받아 STUDENT 테이블에
저장된 학생정보를 검색하여 입력태그의 초기값으로 설정하여 응답하는 JSP 문서 --%>
<%-- => [학생변경] 버튼을 누른 경우 학생정보 변경처리페이지(updateStudent.jsp)를 요청하여 변경값 전달--%>
<%-- => [학생목록] 버튼을 누른 경우 학생목록 응답페이지(displayStudent.jsp)로 이동 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("no")==null) {
		session.setAttribute("message", "비정상적인 방법으로 페이지를 요청 하였습니다.");
		response.sendRedirect("displayStudent.jsp");
		return;
	}
	
	//전달된 학번을 반환받아 저장
	int no=Integer.parseInt(request.getParameter("no"));
	
	//학번을 전달하여 STUDENT 테이블의 저장된 학생정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	StudentDTO student=StudentDAO.getDAO().getStudent(no);
	
	//비정상적인 요청에 대한 응답 처리 - 검색된 학생정보가 없는 경우  
	if(student==null) {
		session.setAttribute("message", "변경하고자 하는 학번의 학생정보가 존재하지 않습니다.");
		response.sendRedirect("displayStudent.jsp");
		return;
	}
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>학생정보 변경폼</title>   
</head>
<body>
	<h1 align="center">학생정보 변경</h1>
	<hr>
	<form name="studentForm">
	<%-- <input type="hidden" name="no" value="<%=student.getNo() %>"> --%>
	<table align="center" border="1" cellpadding="1" cellspacing="0" width="300">
		<tr height="40">
			<th bgcolor="yellow" width="100">학생번호</th>
			<td width="200" align="center">
				<%-- <%=student.getNo() %> --%>
				<input type="text" name="no" value="<%=student.getNo() %>" readonly>
			</td>
		</tr>
		<tr height="40">
			<th bgcolor="yellow" width="100">이름</th>
			<td width="200" align="center">
				<input type="text" name="name" value="<%=student.getName()%>">
			</td>
		</tr>
		<tr height="40">
			<th bgcolor="yellow" width="100">전화번호</th>
			<td width="200" align="center">
				<input type="text" name="phone" value="<%=student.getPhone()%>">
			</td>
		</tr>
		<tr height="40">
			<th bgcolor="yellow" width="100">주소</th>
			<td width="200" align="center">
				<input type="text" name="address" value="<%=student.getAddress()%>">
			</td>
		</tr>
		<tr height="40">
			<th bgcolor="yellow" width="100">생년월일</th>
			<td width="200" align="center">
				<input type="text" name="birthday" value="<%=student.getBirthday()%>">
			</td>
		</tr>
		<tr height="40">
			<td width="200" colspan="2" align="center">
				<input type="button" value="학생변경" onclick="submitCheck();">
				<input type="reset" value="초기화">
				<input type="button" value="학생목록" onclick="location.href='displayStudent.jsp';">
			</td>
		</tr>
	</table>
	</form>
	<script type="text/javascript">
	function submitCheck() {
		if(studentForm.name.value=="") {
			alert("이름을 입력해 주세요.");
			studentForm.name.focus();
			return;
		}

		if(studentForm.phone.value=="") {
			alert("전화번호을 입력해 주세요.");
			studentForm.phone.focus();
			return;
		}

		if(studentForm.address.value=="") {
			alert("주소을 입력해 주세요.");
			studentForm.address.focus();
			return;
		}

		if(studentForm.birthday.value=="") {
			alert("생년월일을 입력해 주세요.");
			studentForm.birthday.focus();
			return;
		}

		studentForm.method="POST";
		studentForm.action="";
		studentForm.submit();
	} 
	</script>
</body>
</html>