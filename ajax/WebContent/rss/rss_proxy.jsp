<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 가상의 브라우저를 이용하여 다른 서버의 문서를 요청하여 응답받을 결과를 제공하는 JSP 문서 --%>
<%-- => 프록시 기능 : HttpClient 클래스 이용 --%>    
<%-- https://www.apache.org 사이트에서 필요한 라이브러리 파일을 다운로드 받아 프로젝트에 빌드 되도록 설정 --%>
<%-- => commons-httpclient-3.1.jar, commons-codec-1.13.jar, commons-logging-1.2.jar --%>
<%
	//요청문서의 URL 주소를 저장한 변수 선언
	String url="http://www.khan.co.kr/rss/rssdata/total_news.xml";

	//HttpClient 클래스로 인스턴스 생성
	// => 웹서버의 자원을 요청하기 위한 가상의 브라우저 생성
	HttpClient client=new HttpClient();
	
	//GetMethod 클래스로 인스턴스 생성
	// => 가상의 브라우저를 이용하여 웹서버의 자원을 요청하기 위한 인스턴스
	// => 요청문서의 URL 주소를 전달하여 인스턴스 생성
	// => GetMethod 클래스 : GET 방식으로 웹서버의 자원을 요청하는 클래스
	// => PostMethod 클래스 : POST 방식으로 웹서버의 자원을 요청하는 클래스
	GetMethod method=new GetMethod(url);
	
	try {
		//HttpClient.executeMethod(Method method) : 가상의 브라우저를 이용하여 웹서버의 자원을 요청하는 메소드
		// => 요청에 대한 응답코드(int)를 반환
		int statusCode=client.executeMethod(method);
		
		//현재 JSP 문서를 요청하는 브라우저(문서)의 응답 관련 인스턴스 초기화
		out.clearBuffer();
		response.reset();
		
		//현재 JSP 문서를 요청하는 브라우저(문서)에 응답코드를 제공
		response.setStatus(statusCode);
		
		//가상의 브라우저로 요청한 문서의 응답코드가 200(HttpServletResponse.SC_OK : 정상응답)인
		//경우 응답 결과를 JSP 문서를 요청한 브라우저(문서)에게 제공
		if(statusCode==HttpServletResponse.SC_OK) {
			//Method.getResponseBodyAsString() : 요청에 대한 응답결과를 문자열로 변환하여 반환하는 메소드
			// => 응답결과의 기본 캐릭터셋(ISO-8859-1)을 원하는 캐릭터셋(UTF-8)으로 변환하여 저장
			String result=new String(method.getResponseBodyAsString().getBytes("8859_1"),"UTF-8");
			
			//요청 브라우저(문서)에세 응답결과에 대한 문서의 종류와 캐릭터셋 제공
			response.setContentType("text/xml;charset=UTF-8");
			
			//요청 브라우저(문서)에게 응답결과 제공
			out.println(result);
		}
	} finally {
		//요청 인스턴스 제거 - 가상의 브라우저를 이용한 웹서버 접속 종료
		if(method!=null) method.releaseConnection();
	}
%>