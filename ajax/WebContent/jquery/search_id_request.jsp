<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 이름과 이메일을 입력받아 해당 회원의 아이디를 출력하는 JSP 문서 --%>
<%-- => 이름과 이메일을 전달하여 AJAX_MEMBER 테이블에 저장된 해당 회원의 아이디를 제공하는 JSP 문서(search_id_response.jsp) 요청 --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<h1>아이디 찾기</h1>
	<hr>
	<%-- 입력 영역 --%>
	<table>
		<tr>
			<td>이름</td>
			<td><input type="text" id="name"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" id="email"></td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="button" id="btn">아이디 찾기</button>
			</td>
		</tr>
	</table>
	<hr>
	<%-- 출력 영역 --%>
	<div id="display"><%-- 홍길동님의 아이디는 [abc123]입니다. --%></div>
	
	<script type="text/javascript">
	$("#name").focus();
	
	$("#btn").click(function() {
		var name=$("#name").val();
		if(name=="") {
			$("#display").html("이름을 입력해 주세요.");
			$("#name").focus();
			return;	
		}
		
		var email=$("#email").val();
		if(email=="") {
			$("#display").html("이메일을 입력해 주세요.");
			$("#email").focus();
			return;	
		}
		
		$("#name").val("");
		$("#email").val("");
		
		$.ajax({
			type: "POST",
			url: "search_id_response.jsp",
			//요청문서에 값을 전달할 경우 [변수=값&변수=값&...] 형식으로 전달
			//data: "name="+name+"&email="+email,
			//요청문서에 값을 전달할 경우 Object 객체({"변수":값,"변수":값,...})로 전달 가능
			data: {"name":name,"email":email},
			dataType: "xml",
			success: function(xmlDoc) {
				var code=$(xmlDoc).find("code").text();
				if(code=="success") {
					var id=$(xmlDoc).find("id").text();
					$("#display").html("<b>"+name+"</b>님의 아이디는 [<b>"+id+"</b>]입니다.");
				} else {
					$("#display").html("<b>"+name+"</b>님의 아이디는 존재하지 않습니다.");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	});
	</script>
</body>
</html>





