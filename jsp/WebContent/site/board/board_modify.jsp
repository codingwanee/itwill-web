<%@page import="site.itwill.dto.MemberDTO"%>
<%@page import="site.itwill.dao.BoardDAO"%>
<%@page import="site.itwill.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글 번호를 전달받아 BOARD 테이블에 저장된 게시글을 검색하여 입력태그에 출력하여 응답하는 JSP 문서 --%>
<%-- => [글수정]을 클릭한 경우 게시글 변경 처리페이지(board_modify_action.jsp)로 이동 --%>    
<%
	//비정상적인 요청에 대한 응답 처리
	// => 전달값이 존재하지 않을 경우
	if(request.getParameter("num")==null) {
		out.println("<script>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=board&work=board_list';");
		out.println("</script>");
		return;
	}
	
	//POST 방식으로 요청되어 전달된 값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
	
	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//게시글 번호를 전달하여 BOARD 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	BoardDTO board=BoardDAO.getDAO().getBoard(num);
	
	//비정상적인 요청에 대한 응답 처리
	// => 검색된 게시글이 없거나 삭제된 게시글인 경우
	if(board==null || board.getStatus()==9) {
		out.println("<script>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=board&work=board_list';");
		out.println("</script>");
		return;
	}
	
	//세션으로 공유된 인증정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
		
	//비정상적인 요청에 대한 응답 처리
	// => 로그인 상태가 아니거나 로그인 사용자가 작성자 또는 관리자가 아닌 경우	
	if(loginMember==null || !loginMember.getId().equals(board.getId()) && loginMember.getStatus()!=9) {
		out.println("<script>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=board&work=board_list';");
		out.println("</script>");
		return;
	}
%>
<style type="text/css">
table {
	margin: 0 auto;
}

td {
	text-align: left;
}

th {
	width: 70px;
	font-weight: normal; 
}
</style>
<h2>글수정</h2>
<form action="<%=request.getContextPath()%>/site/board/board_modify_action.jsp" method="post" id="boardForm">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="search" value="<%=search%>">
<input type="hidden" name="keyword" value="<%=keyword%>">
<table>
	<tr>
		<th>제목</th>
		<td>
			<input type="text" name="subject" id="subject" size="40" value="<%=board.getSubject()%>">
			<input type="checkbox" name="secret" value="1" 
				<% if(board.getStatus()==1) { %> checked="checked" <% } %>>비밀글
		</td>
	</tr>
	<tr>		
		<th>내용</th>
		<td>
			<textarea rows="7" cols="60" name="content" id="board_content"><%=board.getContent() %></textarea>
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<button type="submit">글수정</button>
			<button type="reset" id="resetBtn">다시입력</button>
		</th>
	</tr>
</table>
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#board_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#board_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
})
</script>