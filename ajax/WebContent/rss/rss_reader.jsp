<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- RSS 서비스를 제공하는 서버의 문서를 요청하여 결과를 응답받아 출력하는 JSP 문서 --%>
<%-- RSS(Really Simple Syndication 또는 Rich Site Summary) : 실시간으로 변경되는 정보를 제공하기 위한 웹서비스 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<h1>RSS Reader</h1>
	<hr>
	<div id="display"></div>
	
	<script type="text/javascript">
	$.ajax({
		type: "GET",
		//AJAX 기능은 현재 서버의 문서만 요청 가능
		// => 다른 서버의 문서 요청 불가능(에러코드 : 0)
		//url: "http://www.khan.co.kr/rss/rssdata/total_news.xml",
		//현재 서버의 문서(프록시 기능) 요청
		url: "rss_proxy.jsp",
		dataType: "xml",
		success: function(xmlDoc) {
			var channelTile=$(xmlDoc).find("channel").children("title").text();
			var html="<h2>"+channelTile+"</h2>";
			
			html+="<ul>";
			$(xmlDoc).find("item").each(function() {
				var title=$(this).find("title").text();
				var link=$(this).find("link").text();
				var date;
				if($(this).find("pubDate").size()!=0) {
					date=$(this).find("pubDate").text();
				} else {
					date=$(this).find("dc\\:date").text();
				}
				html+="<li><a href='"+link+"'>"+title+"["+date+"]</a></li>";
			});
			html+="</ul>";
			
			$("#display").html(html);
		},
		error: function(xhr) {
			$("#display").html("에러코드 = "+xhr.status);
		}
	});
	</script>
</body>
</html>