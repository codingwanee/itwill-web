<%@page import="site.itwill.dao.ZipcodeDAO"%>
<%@page import="site.itwill.dto.ZipcodeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 동이름을 전달받아 ZIPCODE 테이블에 저장된 주소정보를 검색하여 우편번호와 기본주소를 응답하는 JSP 문서 --%>
<%-- => [주소검색]을 클릭한 경우 동이름을 전달하여 검색페이지(post_search.jsp)로 이동--%>
<%-- => [기본주소]을 클릭한 경우 해당 우편번호와 기본주소를 부모창의 입력태그로 전달하고 창닫기 --%>
<%
	//POST 방식으로 전달되는 입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");

	List<ZipcodeDTO> zipcodeList=null;
	if(request.getParameter("dong")!=null) {//동이름이 전달된 경우
		//입력된 동이름을 반환받아 저장
		String dong=request.getParameter("dong");
	
		//동이름을 전달하여 ZIPCODE 테이블에 저장된 행을 검색하여 반환하는 DAO 클래스의 메소드 호출
		zipcodeList=ZipcodeDAO.getDAO().getZipcodeList(dong);
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<style type="text/css">
#searchDiv {
	width: 500px;
	margin: 0 auto;
	text-align: center;
}

table {
	margin: 10px;
	border: 1px solid black;
	border-collapse: collapse;
	font-size: 14px; 
}

td {
	border: 1px solid black;
}

.zipcode {
	width: 100px;
}

.address {
	width: 400px;
	text-align: left;
}

a, a:visited {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: underline;
	color: orange;
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="searchDiv">
	<form method="post" name="postForm" onsubmit="return submitCheck();">
		동이름 : <input type="text" name="dong">
		<button type="submit">주소검색</button>	
	</form>
	
	<%-- 검색된 주소정보(우편번호와 기본주소)를 출력 --%>
	<% if(zipcodeList!=null) {//검색된 경우 %>
	<table id="display">
		<tr>
			<td class="zipcode">우편번호</td>
			<td class="address" style="text-align: center;">기본주소</td>
		</tr>
		
		<% for(ZipcodeDTO zipcode:zipcodeList) { %>
		<tr>
			<td class="zipcode"><%=zipcode.getZipcode()%></td>
			<%-- a 태그의 href 속성값으로 JavaScript 명령을 사용할 경우 javascript 접두사를 반드시 사용 --%>
			<td class="address"><a href="javascript:sendClose('<%=zipcode.getZipcode()%>','<%=zipcode.getAddress()%>');"><%=zipcode.getAddress()%></a></td>
		</tr>
		<% } %>
	</table>
	<% } %>
	</div>
	
	<script type="text/javascript">
	postForm.dong.focus();

	function submitCheck() {
		if(postForm.dong.value=="") {
			postForm.dong.focus();
			return false;
		}
		return true;
	}
	
	function sendClose(code,addr) {
		opener.joinForm.zipcode.value=code;
		opener.joinForm.address1.value=addr;
		window.close();
	}
	</script>
</body>
</html>


