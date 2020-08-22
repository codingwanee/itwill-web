<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- books_response.jsp 문서를 jQuery의 AJAX 기능을 이용하여 요청하고 응답
결과(XML)를 제공받아 출력하는 JSP 문서 --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<h1>jQuery 라이브러리의 AJAX 기능 사용(XML 응답)</h1>
	<hr>
	<div id="bookList"></div>
	
	<script type="text/javascript">
	$.ajax({
		type: "GET",
		url: "books_response.jsp",
		dataType: "xml",
		success: function(xmlDoc) {
			//alert(xmlDoc);
			
			var count=$(xmlDoc).find("book").size();
			//alert("count = "+count);
			if(count<=0) {
				$("#bookList").html("교재가 하나도 존재하지 않습니다.");
				return;
			}
			
			var html="<ol>";
			$(xmlDoc).find("book").each(function() {
				var title=$(this).find("title").text();
				var author=$(this).find("author").text();
				html+="<li><b>"+title+"</b>("+author+")</li>";
			});
			html+="</ol>";
			
			$("#bookList").html(html);
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
	</script>
</body>
</html>


