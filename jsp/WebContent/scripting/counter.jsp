<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	//선언문(Declaration) 내부에서 작성된 명령은 클래스의 명령
	// => 클래스 변수(필드)로 선언 - 자동 초기화
	// => 인스턴스 종료(컨테이너 종료)되면 필드는 자동 소멸
	int count;
%>    
<%
	//명령문(Scriptlet) 내부에서 작성된 명령은 _jspService() 메소드의 명령
	// => _jspService() 메소드에 선언된 지역변수
	// => 메소드 종료(응답 완료)되면 지역변수는 자동 소멸
	//int count=0;
	count++;
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>스크립팅 요소(Scripting Elements)</h1>
	<hr>
	<%-- out : JSP 문서에서 제공되는 내부 인스턴스 중 
	하나로 응답문서에 값을 출력하는 기능을 제공하는 인스턴스 --%>
	<%-- <p>JSP 문서의 요청 횟수 = <% out.println(count); %></p> --%>
	
	<%-- 표현식(Expression) 내부의 변수값,연산식 결과값,메소드 반환값을 문자열로
	변환하여 out 인스턴스의 메소드를 호출하여 출력 --%>
	<p>JSP 문서의 요청 횟수 = <%=count%></p>
</body>
</html>