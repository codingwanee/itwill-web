<%@page import="java.text.DecimalFormat"%>
<%@page import="site.itwill.dao.ProductDAO"%>
<%@page import="site.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 카테고리를 전달받아 PRODUCT 테이블에 저장된 카테고리별 제품목록을 검색하여 응답하는 JSP 문서 --%>
<%-- => [제품등록]를 클릭할 경우 제품정보 입력페이지(product_add.jsp)로 이동 --%>
<%-- => [카테고리]를 변경할 경우 제품목록 출력페이지(product_list.jsp)로 이동 --%>
<%-- => [제품이름]을 클릭할 경우 제품상세 출력페이지(product_detail.jsp)로 이동 --%>
<%@include file="../security/admin.jspf" %>
<%
	//전달된 카테고리를 반환받아 저장
	String category=request.getParameter("category");
	if(category==null) category="ALL";
	
	//카테고리를 전달하여 PRODUCT 테이블에 저장된 카테고리별 제품목록을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList=ProductDAO.getDAO().getProductList(category);
%>
<style type="text/css">
#wrapper {
	width: 800px;
	margin: 10px auto;
}

#btnDiv {
	text-align: right;
	margin-bottom: 5px;	
}

table {
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
	text-align: center;
	width: 200px;
}

.pname { width: 400px; }

td a:hover {
	text-decoration: none;
	color: blue;
}
</style>

<div id="wrapper">
	<h2>제품목록</h2>
	<div id="btnDiv">
		<button type="button" id="addBtn">제품등록</button>
	</div>
	
	<table>
		<tr>
			<td>제품코드</td>
			<td class="pname">제품이름</td>
			<td>제품수량</td>
			<td>제품가격</td>
		</tr>
		
		<% if(productList.isEmpty()) { %>
		<tr>
			<td colspan="4">등록된 제품이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<% for(ProductDTO product:productList) { %>
			<tr>
				<td><%=product.getProductCode() %></td>
				<td><a href="index.jsp?workgroup=admin&work=product_detail&productNum=<%=product.getProductNum()%>"><%=product.getProductName() %></a></td>
				<%-- DecimalFormat 클래스 : 숫자에 대한 패턴정보를 저장하여 변환기능을 제공하는 클래스 --%>
				<%-- DecimalFormat.getInstance() : 숫자에 대한 기본 패턴정보를 저장한 인스턴스를 반환하는 메소드 --%>
				<%-- DecimalFormat.format(long number) : 인스턴스에 저장된 패턴정보를 이용하여 전달받은 숫자를 변환하여 반환하는 메소드 --%>
				<td><%=DecimalFormat.getInstance().format(product.getProductQty())%></td>
				<%-- <td><%=DecimalFormat.getInstance().format(product.getProductPrice()) %>원</td> --%>
				<td><%=DecimalFormat.getCurrencyInstance().format(product.getProductPrice()) %></td>
			</tr>
			<% } %>
		<% } %>
	</table>
	<br>
	
	<form method="post" id="categoryForm">
		<select name="category" id="categoty">
			<option value="ALL" <% if(category.equals("ALL")) { %> selected <% } %>>전체</option>
			<option value="CPU" <% if(category.equals("CPU")) { %> selected <% } %>>중앙처리장치(CPU)</option>
			<option value="MAINBOARD" <% if(category.equals("MAINBOARD")) { %> selected <% } %>>메인보드</option>
			<option value="MEMORY" <% if(category.equals("MEMORY")) { %> selected <% } %>>주기억장치(Memory)</option>
		</select>
	</form>
</div>

<script type="text/javascript">
$("#addBtn").click(function() {
	location.href="<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=product_add";
});

$("#categoty").change(function() {
	$("#categoryForm").submit();
});
</script>