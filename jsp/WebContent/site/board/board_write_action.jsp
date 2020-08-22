<%@page import="site.itwill.util.Utility"%>
<%@page import="site.itwill.dto.BoardDTO"%>
<%@page import="site.itwill.dto.MemberDTO"%>
<%@page import="site.itwill.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(board_write.jsp)에서 전달된 게시글(새글 또는 답글)을 반환받아 
BOARD 테이블에 저장하고  게시글 목록 출력페이지(board_list.jsp)로 이동하는 JSP 문서 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//POST 방식으로 요청되어 전달된 값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("UTF-8");
	
	//전달된 입력값을 반환받아 저장
	int ref=Integer.parseInt(request.getParameter("ref"));
	int reStep=Integer.parseInt(request.getParameter("reStep"));
	int reLevel=Integer.parseInt(request.getParameter("reLevel"));
	String pageNum=request.getParameter("pageNum");
	
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
	
	//BOARD_SEQ 객체의 자동 증가값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	int num=BoardDAO.getDAO().getBoardNum();
	
	//세션으로 공유된 인증정보(회원정보)를 반환받아 저장 
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//게시글 작성 클라이언트의 IP 주소를 반환받아 저장
	//request.getRemoteAddr() : 요청 클라이언트의 IP 주소를 반환하는 메소드
	// => WAS에 의해 IPV6 프로토콜의 128bit 형식의 IP 주소 제공
	// => Run > Run Configurations... > Apache Tomcat > Tomcat ... 
	//    > Arguments > VM Arguments > -Djava.net.preferIPv4Stack=true 추가
	String ip=request.getRemoteAddr();
	
	//새글 또는 답글 구분하여 처리
	if(ref==0) {//새글
		ref=num;
	} else {//답글
		//BOARD 테이블에 저장된 기존 게시글 정보를 변경하는 DAO 클래스의 메소드 호출
		// => BOARD 테이블의 REF 컬럼값과 부모글의 ref 전달값이 같고 BOARD 테이블의 RE_SETP 컬럼값이  
		//    부모글의 reStep 전달값보다 큰 행의 RE_SETP 컬럼값을 1 증가되도록 변경
		BoardDAO.getDAO().modifyReSetp(ref, reStep);
		
		//부모글의 reStep 전달값과 reLevel 전달값 1 증가
		reStep++;
		reLevel++;
	}
	
	//DTO 인스턴스 생성 후 필드값 변경
	BoardDTO board=new BoardDTO();
	board.setNum(num);//자동 증가값
	board.setId(loginMember.getId());//로그인 사용자 아이디
	board.setWriter(loginMember.getName());//로그인 사용자 이름
	board.setSubject(subject);//입력값
	board.setRef(ref);//새글 : 자동 증가값, 답글 : 부모글 전달값
	board.setReStep(reStep);//새글 : 0, 답글 : 부모글 전달값 + 1
	board.setReLevel(reLevel);//새글 : 0, 답글 : 부모글 전달값 + 1
	board.setContent(content);//입력값
	board.setIp(ip);//클라이언트 IP 주소
	board.setStatus(status);//일반글 : 0, 비밀글 : 1
	
	//게시글을 전달하여 BOARD 테이블에 저장하는 DAO 클래스의 메소드 호출
	BoardDAO.getDAO().addBoard(board);
	
	//게시글 목록 출력페이지 이동
	response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=board&work=board_list&pageNum="+pageNum);
%>