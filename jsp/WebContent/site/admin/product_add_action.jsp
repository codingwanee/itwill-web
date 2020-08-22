<%@page import="java.io.File"%>
<%@page import="site.itwill.dao.ProductDAO"%>
<%@page import="site.itwill.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(product_add.jsp)에서 전달된 제품정보로 PRODUCT 테이블에 
저장하고 제품목록 출력페이지(product_list.jsp)로 이동하는 JSP 문서 --%>
<%-- => 입력된 파일을 전달받아 특정 디렉토리에 업로드 처리 --%>
<%-- => 입력된 제품코드가 중복될 경우 제품정보 입력페이지(product_add.jsp)로 이동 --%>
<%@include file="../security/admin.jspf" %>
<%
	//입력파일을 업로드 하기 위한 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/site/product_image");

	//MultipartRequest 인스턴스 생성
	// => 입력파일이 디렉토리에 자동 업로드 처리
	MultipartRequest mr=new MultipartRequest(request,saveDirectory
			,30*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
	
	//입력값 또는 업로드 파일명을 반환받아 저장
	String productCode=mr.getParameter("category")+"_"+mr.getParameter("productCode");
	String productName=mr.getParameter("productName");
	String mainImage=mr.getFilesystemName("mainImage");
	String productDetail=mr.getParameter("productDetail");
	int productQty=Integer.parseInt(mr.getParameter("productQty"));
	int productPrice=Integer.parseInt(mr.getParameter("productPrice"));
	
	//DTO 인스턴스 생성하고 입력값으로 필드값 변경
	ProductDTO product=new ProductDTO();
	product.setProductCode(productCode);
	product.setProductName(productName);
	product.setMainImage(mainImage);
	product.setProductDetail(productDetail);
	product.setProductQty(productQty);
	product.setProductPrice(productPrice);
	
	//제품코드를 전달하여 PRODUCT 테이블에 저장 유무를 검색하여 반환하는 DAO 클래스의 메소드 호출
	//=> 입력된 제품코드가 이미 PRODUCT 테이블에 저장된 경우
	if(ProductDAO.getDAO().isProduct(productCode)) {
		//자동으로 업로드 처리된 입력파일을 제거
		new File(saveDirectory,mainImage).delete();
		session.setAttribute("message", "이미 저장된 제품코드를 입력 하였습니다.");
		session.setAttribute("product", product);
		response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=admin&work=product_add");
		return;
	}
	
	//제품정보를 전달하여 PRODUCT 테이블에 저장하는 DAO 클래스의 메소드 호출
	ProductDAO.getDAO().addProduct(product);
	
	//제품목록 출력페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=admin&work=product_list");
%>
