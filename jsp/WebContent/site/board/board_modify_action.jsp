<%@page import="java.net.URLEncoder"%>
<%@page import="site.itwill.dao.BoardDAO"%>
<%@page import="site.itwill.dto.BoardDTO"%>
<%@page import="site.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(board_modify.jsp)에서 전달된 게시글을 반환받아 BOARD 테이블에 
저장된 게시글을 변경하고 게시글 상세 출력페이지(board_detail.jsp)로 이동하는 JSP 문서 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//POST 방식으로 요청되어 전달된 값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
	
	//전달된 입력값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=URLEncoder.encode(request.getParameter("keyword"),"UTF-8");
	
	//XSS(입력값으로 태그를 입력하는 기술)에 대한 처리
	// => 태그 관련 문자를 Escape 문자로 변환하거나 제거
	String subject=Utility.stripTag(request.getParameter("subject"));
	int status=0;
	if(request.getParameter("secret")!=null) {
		status=Integer.parseInt(request.getParameter("secret"));
	}
	String content=Utility.stripTag(request.getParameter("content"));

	//태그 제거에 의해 입력값이 없을 경우에 대한 처리
	if(subject==null|| subject.equals("") || content==null || content.equals("")) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	//DTO 인스턴스 생성 후 필드값 변경
	BoardDTO board=new BoardDTO();
	board.setNum(num);
	board.setSubject(subject);
	board.setStatus(status);
	board.setContent(content);
	
	//게시글을 전달하여 BOARD 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	BoardDAO.getDAO().modifyBoard(board);
	
	//게시글 상세 출력페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=board&work=board_detail&num="+num+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword);
%>











