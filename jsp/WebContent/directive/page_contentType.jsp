<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> --%>
<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<style type="text/css">
table {
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
	text-align: center;
	width: 200px;
}
</style>
</head>
<body>
	<h1>page Directive - contentType 속성</h1>
	<hr>
	<p>JSP 문서를 요청한 경우 클라이언트에 전달하는 
	파일의 유형(MimeType)과 캐릭터셋(CharacterSet - Encoding)을 제공하는 속성</p>
	<hr>
	<table>
		<tr>
			<td>학번</td><td>이름</td><td>전화번호</td><td>주소</td>
		</tr>
		<tr>
			<td>1000</td><td>홍길동</td><td>010-1564-6754</td><td>서울시 강남구 역삼동</td>
		</tr>
		<tr>
			<td>2000</td><td>임꺽정</td><td>016-132-4515</td><td>인천시 월미구 상당동</td>
		</tr>
		<tr>
			<td>3000</td><td>전우치</td><td>019-1234-5461</td><td>수원시 팔달구 구래동</td>
		</tr>
	</table> 
</body>
</html>