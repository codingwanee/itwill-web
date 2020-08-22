<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//제어권이 이동된 JSP 문서에서는 요청문서에서 전달된
	//리퀘스트 메세지(request)와 리스폰지 메세지(response)의 BODY 영역은
	//사용 가능하지만 HEAD 영역은 사용 불가능
	// => request 인스턴스를 이용하여 요청에 설정 변경 불가능
	// => response 인스턴스를 이용하여 응답에 대한 상태코드 전달 불가능
	//request.setCharacterEncoding("UTF-8");
	String master=request.getParameter("master");
%>    
<hr>
<p>Copyright ⓒ itwill Corp. All rights reserved.</p>
<%-- <p>관리자 : 홍길동(abc@google.com)</p> --%>
<p>관리자 : <%=master %></p>