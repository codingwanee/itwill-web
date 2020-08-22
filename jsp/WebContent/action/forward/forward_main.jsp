<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>forward Action Tag</h1>
	<hr>
	<p>현재 JSP 문서(요청처리)에서 다른 JSP 문서(응답)로 스레드를 이동하는 태그</p>
	<p>형식) &lt;jsp:forward page="JSP 문서명"&gt;&lt;/jsp:forward&gt;</p>
	<hr>
	<a href="controller.jsp?category=product">제품소개</a>&nbsp;&nbsp;
	<a href="controller.jsp?category=cart">장바구니</a>&nbsp;&nbsp;
	<a href="controller.jsp?category=order">주문내역</a>&nbsp;&nbsp;
	<a href="controller.jsp?category=review">사용후기</a>&nbsp;&nbsp;
</body>
</html>





