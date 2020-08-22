<%@page import="java.io.File"%>
<%@page import="site.itwill.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호를 전달받아 PRODUCT 테이블에 저장된 제품정보를 삭제하고 
제품목록 출력페이지(product_list.jsp)로 이동하는 JSP 문서 --%>
<%-- => 삭제된 제품의 제품이미지 파일 삭제 처리 --%>
<%@include file="../security/admin.jspf" %>
<%
	//전달된 제품번호를 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));

	//제품이미지 파일 삭제
	String saveDirectory=request.getServletContext().getRealPath("/site/product_image");
	String mainImage=ProductDAO.getDAO().getProduct(productNum).getMainImage();
	new File(saveDirectory,mainImage).delete();
	
	//제품번호를 전달하여 PRODUCT 테이블에 저장된 제품정보를 삭제하는 DAO 클래스의 메소드 호출
	ProductDAO.getDAO().removeProduct(productNum);
	
	//제품목록 출력페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=admin&work=product_list");
%>