<%@page import="java.text.DecimalFormat"%>
<%@page import="site.itwill.dao.ProductDAO"%>
<%@page import="site.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호를 전받아 PRODUCT 테이블에 저장된 제품정보를 검색하여 응답하는 JSP 문서 --%>
<%-- [제품정보변경]을 클릭한 경우 제품정보변경 입력페이지(product_modify.jsp)로 이동 --%>
<%-- [제품정보삭제]을 클릭한 경우 제품정보삭제 처리페이지(product_remove_action.jsp)로 이동 --%>
<%@include file="../security/admin.jspf" %>
<%
	//전달된 제품번호를 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));

	//제품번호를 전달하여 PRODUCT 테이블에 저장된 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().getProduct(productNum);
%>
<style type="text/css">
table {
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;
}

td { 
	border: 1px solid black; 
}	

.title {
	background: black;
	color: white;
	text-align: center;
	width: 100px;
}

.value {
	padding: 3px;
	text-align: left;
	width: 400px;
}
</style>
<h2>제품상세정보</h2>
<table>
	<tr>
		<td class="title">제품코드</td>
		<td class="value"><%=product.getProductCode() %></td>
	</tr>
	<tr>
		<td class="title">제품이름</td>
		<td class="value"><%=product.getProductName() %></td>
	</tr>
	<tr>
		<td class="title">제품이미지</td>
		<td class="value"><img src="<%=request.getContextPath()%>/site/product_image/<%=product.getMainImage() %>" width="200"></td>
	</tr>
	<tr>
		<td class="title">상세설명</td>
		<td class="value"><%=product.getProductDetail().replace("\n", "<br>") %></td>
	</tr>
	<tr>
		<td class="title">제품수량</td>
		<td class="value"><%=DecimalFormat.getInstance().format(product.getProductQty()) %></td>
	</tr>
	<tr>
		<td class="title">제품가격</td>
		<td class="value"><%=DecimalFormat.getCurrencyInstance().format(product.getProductPrice()) %></td>
	</tr>
	<tr>
		<td class="title">등록일자</td>
		<td class="value"><%=product.getAddDate().substring(0, 19) %></td>
	</tr>
</table>

<p>
	<button type="button" id="modifyBtn">제품정보변경</button>
	<button type="button" id="removeBtn">제품정보삭제</button>
</p>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=product_modify&productNum=<%=product.getProductNum()%>";
});

$("#removeBtn").click(function() {
	if(confirm("정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/site/admin/product_remove_action.jsp?productNum=<%=product.getProductNum()%>";
	}
});
</script>







