<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="site.itwill.dto.MemberDTO"%>
<%@page import="site.itwill.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="site.itwill.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- BOARD 테이블에 저장된 게시글을 검색하여 게시글 목록을 응답하는 JSP 문서 --%>
<%-- => 페이지에 응답될 게시글 갯수 제한 - 페이징 처리 --%>
<%-- => 요청 페이지 번호 출력 - 페이징 처리 --%>
<%-- => [번호]를 클릭한 경우 페이지번호를 전달하여 현재 페이지 요청 --%>
<%-- => [검색]를 클릭한 경우 검색대상과 검색키워드를 전달하여 현재 페이지 요청 --%>
<%-- => [글쓰기]를 클릭한 경우 게시글 입력페이지(board_write.jsp)로 이동 - 새글 쓰기 --%>
<%-- => [게시글제목]을 클릭한 경우 게시글 상세 출력페이지(board_detail.jsp)로 이동 --%>
<%
	//포함될 JSP 문서에서는 request 인스턴스의 정보 변경 불가능
	// => 템플릿 페이지(index.jsp)에서 request 인스턴스의 정보 변경
	//request.setCharacterEncoding("UTF-8");	

	//입력된 검색대상과 검색키워드를 반환받아 저장
	String search=request.getParameter("search");
	if(search==null) search="";
	String keyword=request.getParameter("keyword");
	if(keyword==null) keyword="";
	
	//전달된 페이지번호를 반환받아 저장
	int pageNum=1;//페이지번호를 저장하기 위한 변수
	if(request.getParameter("pageNum")!=null) {//전달값이 존재할 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//페이지에 응답될 게시글의 갯수 설정
	int pageSize=10;//응답 게시글의 갯수를 저장하기 위한 변수
	
	//BOARD 테이블에 저장된 전체 게시글의 갯수를 반환하는 DAO 클래스의 메소드 호출
	//int totalBoard=BoardDAO.getDAO().getBoardTotal();//전체 게시글의 갯수를 저장하기 위한 변수
	//검색대상과 검색키워드를 전달하여 BOARD 테이블에 저장된 검색 게시글의 갯수를 반환하는 DAO 클래스의 메소드 호출
	int totalBoard=BoardDAO.getDAO().getBoardTotal(search,keyword);
	       
	//총 페이지 갯수를 계산하여 저장
	//int totalPage=totalBoard/pageSize+(totalBoard%pageSize==0?0:1);//총 페이지 갯수를 저장하기 위한 변수
	int totalPage=(int)Math.ceil((double)totalBoard/pageSize);

	//전달받은 페이지 번호에 대한 유효성 검사
	if(pageNum<=0 || pageNum>totalPage) {
		//비정상적인 페이지 번호가 전달된 경우 무조건 1 페이지로 설정 
		pageNum=1;
	}
	
	//페이지 번호에 대한 게시글 시작 행번호를 계산하여 저장
	// => 1 Page : 1, 2 Page : 11, 3 Page : 21, 4 Page : 31,... 
	int startRow=(pageNum-1)*pageSize+1;
	
	//페이지 번호에 대한 게시글 종료 행번호를 계산하여 저장
	// => 1 Page : 10, 2 Page : 20, 3 Page : 30, 4 Page : 40,... 
	int endRow=pageNum*pageSize;
	
	//마지막 페이지의 게시글 종료 행번호를 게시글 전체 갯수로 변경
	if(endRow>totalBoard) {
		endRow=totalBoard;
	}

	//시작 행번호와 종료 행번호를 전달하여 BOARD 테이블에서 페이지에 
	//응답될 게시글 목록을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<BoardDTO> boardList=BoardDAO.getDAO().getBoardList(startRow, endRow, search, keyword);
	
	//페이지에 응답될 게시글의 출력시작번호를 계산하여 저장
	// => 게시글이 하나 출력될 때마다 1씩 감소
	int number=totalBoard-(pageNum-1)*pageSize;
	                    
	//세션으로 공유된 인증정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//서버의 현재 날짜(시간)정보 저장
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>
<style type="text/css">
#board_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#board_title {
	font-size: 1.3em;
	font-weight: bold;
}	

#btn {
	text-align: right;
}

table {
	margin: 5px auto;
	border: 1px solid black;
	border-collapse: collapse; 
}

th {
	border: 1px solid black;
	background: black;
	color: white;
}

td {
	border: 1px solid black;
}

.subject {
	text-align: left;
	padding-left: 5px;
	overflow: hidden;
	text-overflow: ellipsis;
}

.secret, .remove {
	background: black;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px; 
}
</style>

<div id="board_list">
	<div id="board_title">
	<% if(keyword.equals("")) { %>	
		전체
	<% } else { %>	
		검색
    <% } %>
	게시글 목록(게시글 갯수 : <%=totalBoard %>)
	</div>
	
	<% if(loginMember!=null) { %>
	<div id="btn">
		<button type="button" id="writeBtn">글쓰기</button>
	</div>
	<% } %>
	
	<table>
		<tr>
			<th width="100">번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="100">조회수</th>
			<th width="200">작성일</th>
		</tr>
		
		<% if(totalBoard==0) { %>
		<tr>
			<td colspan="5">검색된 게시글이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<%-- 게시글 목록 출력 --%>
			<% for(BoardDTO board:boardList) { %>
			<tr>
				<%-- 글번호 --%>
				<td><%=number %></td>
				
				<%-- 제목 --%>
				<td class="subject">
					<% if(board.getReStep()!=0) {//답글인 경우 %>
					<%-- 왼쪽 여백은 답글 깊이에 따라 다르게 출력 --%>
					<span style="margin-left: <%=board.getReLevel()*20 %>px;">└[답글]</span>
					<% } %>
					<%-- 게시글 상태에 따른 제목 출력 및 하이퍼 링크 --%>
					<% if(board.getStatus()==0) {//일반글인 경우 %>
					<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_detail&num=<%=board.getNum()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>"><%=board.getSubject() %></a>
					<% } else if(board.getStatus()==1) {//비밀글인 경우 %>
					<span class="secret">비밀글</span>
						<% if(loginMember!=null && (board.getId().equals(loginMember.getId()) || loginMember.getStatus()==9)) { %>
						<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_detail&num=<%=board.getNum()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">작성자 또는 관리자만 확인 가능합니다.</a>
						<% } else { %>
						작성자 또는 관리자만 확인 가능합니다.
						<% } %>
					<% } else if(board.getStatus()==9) {//삭제글인 경우 %>
					<span class="remove">삭제글</span>
					작성자 또는 관리자에 의해 삭제된 게시글입니다.
					<% } %>
				</td>
				
				<% if(board.getStatus()!=9) {//삭제글이 아닌 경우 %>
					<%-- 작성자 --%>
					<td><%=board.getWriter() %></td>
					
					<%-- 조회수 --%>
					<td><%=board.getReadCount() %></td>
					
					<%-- 작성일 --%>
					<td>
						<% if(currentDate.equals(board.getRegDate().substring(0,10))) { %>
						<%=board.getRegDate().substring(11, 19) %>
						<% } else { %>
						<%=board.getRegDate().substring(0, 19) %>
						<% } %>
					</td>
				<% } else {//삭제글인 경우 %>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				<% } %>				
			</tr>
			<% number--; %>			
			<% } %>
		<% } %>
	</table>
	
	<%-- 페이지 번호 출력(페이징 처리) 및 하이퍼 링크 --%>
	<%
		//페이지 블럭에 출력될 페이지 번호의 갯수를 설정하여 저장
		int blockSize=5;//블럭에 출력될 페이지 번호의 갯수를 저장하기 위한 변수
		
		//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 출력
		// => 1 Block(1~5) : 1, 2 Block(6~10) : 6, 3 Block(11~15) : 11, 4(16~20) Block : 16,... 
		int startPage=(pageNum-1)/blockSize*blockSize+1;//블럭에 출력될 페이지 시작 페이지번호를 저장하기 위한 변수
		
		//페이지 블럭에 출력될 마지막 페이지 번호를 계산하여 출력
		// => 1 Block(1~5) : 5, 2 Block(6~10) : 10, 3 Block(11~15) : 15, 4(16~20) Block : 20,...
		int endPage=startPage+blockSize-1;
		
		//마지막 페이지 블럭의 페이지 번호 변경
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>

	<%-- 페이지 번호 출력 및 하이퍼 링크 --%>
	<div>
	<% if(startPage>blockSize) { %>
	<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
	<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else { %>
	[처음][이전]
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
		<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
		<% } else { %>
		<span style="font-weight: bold; color: red;">[<%=i %>]</span>
		<% } %>
	<% } %>
	
	<% if(endPage!=totalPage) { %>
	<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
	<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else { %>
	[다음][마지막]
	<% } %>
	</div>
	<br>
	
	<%-- 게시글 검색 --%>
	<form action="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_list" method="post" id="searchForm">
		<select name="search">
			<option value="writer" selected="selected">&nbsp;작성자&nbsp;</option>
			<option value="subject">&nbsp;제목&nbsp;</option>
			<option value="content">&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword" id="keyword">
		<button type="submit">검색</button>
	</form>
</div>

<script type="text/javascript">
$("#writeBtn").click(function() {
	location.href="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_write";
});

/*
$("#searchForm").submit(function() {
	if($("#keyword").val()=="") {
		alert("검색 키워드를 입력해 주세요.");
		$("#keyword").focus();
		return false;
	}	
});
*/
</script>