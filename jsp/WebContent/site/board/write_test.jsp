<%@page import="site.itwill.dao.BoardDAO"%>
<%@page import="site.itwill.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	for(int i=1;i<=500;i++) {
		BoardDTO board=new BoardDTO();
		int num=BoardDAO.getDAO().getBoardNum();
		board.setNum(num);
		board.setId("xyz789");
		board.setWriter("임꺽정");
		board.setSubject("테스트-"+i);
		board.setRef(num);
		board.setContent("내용-"+i);
		board.setIp("127.0.0.1");
		BoardDAO.getDAO().addBoard(board);
	}
%>
<h1>500개의 테스트 게시글 저장 하였습니다.</h1>