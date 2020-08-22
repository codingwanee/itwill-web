<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>제품목록</h1>
<%-- 현재문서를 기준으로 리소스 파일의 상대경로 표현 --%>
<%-- => 요청문서를 이용하여 포함될 경우 404 에러 발생 --%>
<%-- <img src="../images/Koala.jpg" width="250"> --%>
<%-- 요청문서를 기준으로 리소스 파일의 상대경로 표현 --%>
<%-- => 현재 문서의 결과를 반드시 요청문서를 통해 확인 --%>
<%-- <img src="images/Koala.jpg" width="250"> --%>
<%-- 리소스 파일을 절대경로로 표현하면 요청문서와 현재문서 모두에서 확인 가능 --%>
<%-- <img src="/jsp/action/template_site/images/Koala.jpg" width="250"> --%>
<%-- => 컨텍스트 이름을 변경 가능하므로 반환받아 작성하는 것을 권장 --%>
<img src="<%=request.getContextPath() %>/action/template_site/images/Koala.jpg" width="250">