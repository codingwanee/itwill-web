<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1><a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=product&work=display">쇼핑몰</a></h1>
<div id="menu">
	<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=product&work=new">신제품</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=product&work=best">추천제품</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=cart&work=display">장바구니</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=order&work=list">구매내역</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/action/template_site/index.jsp?part=board&work=list">게시판</a>&nbsp;&nbsp;
</div>