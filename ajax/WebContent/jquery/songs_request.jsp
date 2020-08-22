<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- songs_response.jsp 문서를 jQuery의 AJAX 기능을 이용하여 요청하고 응답
결과(JSON)를 제공받아 출력하는 JSP 문서 --%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<h1>jQuery 라이브러리의 AJAX 기능 사용(JSON 응답)</h1>
	<hr>
	<h2>음원차트(<span id="now"></span> 현재 기준)</h2>
	<div id="songList"></div>
	
	<script type="text/javascript">
	$.ajax({
		type: "GET",
		url: "songs_response.jsp",
		dataType: "json",
		success: function(data) {
			$("#now").html(data.now);
			
			var html="<ol>";
			$(data.songs).each(function() {
				html+="<li><b>"+this.title+"</b> - "+this.singer+"</li>";
			});
			html+="</ol>";
			
			$("#songList").html(html);
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
	</script>
</body>
</html>