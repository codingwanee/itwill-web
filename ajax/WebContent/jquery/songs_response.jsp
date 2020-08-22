<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 날짜 및 시간정보와 음원정보를 JSON 텍스트 데이타를 응답하는 JSP 문서 --%>    
<%
	String now=new SimpleDateFormat("yyyy년 MM월 dd일 HH시").format(new Date());
%>
{"now":"<%=now %>","songs":[{"title":"그대라는 시","singer":"태연(TAEYEON)"}
	,{"title":"술이 문제야","singer":"장혜진, 윤민수"}
	,{"title":"ICY","singer":"ITZY(있지)"}
	,{"title":"헤어져줘서 고마워","singer":"벤"}
	,{"title":"Snapping","singer":"청하"}]}