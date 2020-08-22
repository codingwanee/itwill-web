<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 댓글을 입력하고 댓글목록을 출력하는 JSP 문서 --%>
<%-- => 댓글 삽입,삭제,변경,검색 기능의 문서를 요청하여 응답받아 처리 --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style type="text/css">
h1 {
	text-align: center;
}

.comment_table {
	width: 500px;
	margin: 0 auto;
	border: 2px solid #cccccc;
	border-collapse: collapse;
}

.title {
	width: 100px;
	padding: 5px 10px;
	text-align: center;
	border: 1px solid #cccccc;
}

.input {
	width: 400px;
	padding: 5px 10px;
	border: 1px solid #cccccc;
}

.btn {
	text-align: center;
	border: 1px solid #cccccc;
}

#comment_add {
	margin-bottom: 5px;
}

#comment_update, #comment_remove {
	margin: 10px;
	display: none;
}

#message, #modify_error {
	width: 500px;
	margin: 0 auto;
	margin-bottom: 20px;
	text-align: center;
	color: red;
}

#remove_message {
	padding: 3px;
	text-align: center;
	border: 1px solid #cccccc;
}

.comment {
	width: 550px;
	margin: 0 auto;
	margin-bottom: 5px;
	padding: 3px;
	border: 2px solid #cccccc;
}

.no_comment {
	width: 550px;
	margin: 0 auto;
	padding-bottom: 3px;
	border: 2px solid #cccccc;
	text-align: center;
}
</style>
</head>
<body>
	<h1>AJAX 댓글</h1>
	<hr>
	<%-- 댓글 입력 영역 --%>
	<div id="comment_add">
		<table class="comment_table">
			<tr>
				<td class="title">작성자</td>
				<td class="input">
					<input type="text" id="writer">
				</td>  
			</tr>		
			<tr>
				<td class="title">댓글내용</td>
				<td class="input">
					<textarea rows="3" cols="50" id="content"></textarea>
				</td>  
			</tr>		
			<tr>
				<td colspan="2" class="btn">
					<button type="button" id="add_btn">댓글등록</button>
				</td>
			</tr>
		</table>
		<div id="message">&nbsp;</div>
	</div>
	
	<%-- 댓글 목록 출력 영역 --%>
	<div id="comment_list"></div>
	
	<%-- 댓글 변경 영역  --%>
	<div id="comment_update">
		<table class="comment_table">
			<tr>
				<td class="title">작성자</td>
				<td class="input">
					<input type="text" id="modify_writer">
				</td>  
			</tr>		
			<tr>
				<td class="title">댓글내용</td>
				<td class="input">
					<textarea rows="3" cols="50" id="modify_content"></textarea>
				</td>  
			</tr>		
			<tr>
				<td colspan="2" class="btn">
					<button type="button" id="modify_btn">댓글변경</button>
					<button type="button" id="modify_cancel_btn">변경취소</button>
				</td>
			</tr>
		</table>
		<div id="modify_error"></div>
	</div>

	<%-- 댓글 삭제 영역 --%>
	<div id="comment_remove">
		<div id="remove_message">
			<b>정말로 삭제 하시겠습니까?</b>
			<button type="button" id="remove_btn">댓글삭제</button>
			<button type="button" id="remove_cancel_btn">삭제취소</button>		
		</div>
	</div>
	
	<script type="text/javascript">
	loadComment();
	
	//댓글목록을 제공하는 문서(comment_list.jsp)를 요청하여 응답받아 출력하는 함수
	function loadComment() {
		$.ajax({
			type: "GET",
			url: "comment_list.jsp",
			dataType: "xml",
			success: function(xmlDoc) {
				var code=$(xmlDoc).find("code").text();
				
				if(code=="success") {//댓글이 있는 경우
					//alert($(xmlDoc).find("data").text());
					
					var commentArray=JSON.parse($(xmlDoc).find("data").text());
					//alert("commentArray.length = "+commentArray.length);
					
					//댓글목록 출력영역 초기화
					$("#comment_list").children().remove();
					
					$(commentArray).each(function() {
						//댓글정보를 엘리먼트로 생성하여 댓글목록 출력영역에 추가
						$("#comment_list").append("<div id='comment_"
							+this.num+"' class='comment' num='"+this.num
							+"'><b>["+this.writer+"]</b><br>"
							+this.content.replace(/\n/g,"<br>")
							+"<br>("+this.writeDate+")<br>"
							+"<button type='button' onclick='modifyComment("+this.num+");'>변경</button>&nbsp;"
							+"<button type='button' onclick='removeComment("+this.num+");'>삭제</button></div>");
					});
				} else {//댓글이 없는 경우
					var message=$(xmlDoc).find("message").text();
					$("#comment_list").html("<div class='no_comment'>"+message+"</div>");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	}
	
	$("#add_btn").click(function() {
		var writer=$("#writer").val();
		if(writer=="") {
			$("#message").html("작성자를 입력해 주세요.");
			$("#writer").focus();
			return;
		}
		
		var content=$("#content").val();
		if(content=="") {
			$("#message").html("댓글내용을 입력해 주세요.");
			$("#content").focus();
			return;
		}
		
		$("#writer").val("");		
		$("#content").val("");	
		$("#message").html("&nbsp;");
		
		$.ajax({
			type: "POST",
			url: "comment_add.jsp",
			data: {"writer":writer,"content":content},
			dataType: "xml",
			success: function(xmlDoc) {
				var code=$(xmlDoc).find("code").text();
				
				if(code=="success") {
					loadComment();
				} else {
					$("#message").html("댓글을 저장하지 못했습니다.");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	});
	
	//[변경]를 누른 경우 호출되는 이벤트 핸들러 함수
	function modifyComment(num) {
		//alert("num = "+num);
		
		//댓글 삭제영역을 숨기고 document 객체의 자식 엘리먼트로 이동
		$("#comment_remove").hide().appendTo(document.documentElement);
		
		//댓글 변경영역을 출력하고 이벤트가 발생된 댓글영역의 자식 엘리먼트로 이동
		$("#comment_update").show().appendTo("#comment_"+num);
		
		//댓글 변경영역의 입력태그에 해당 댓글정보를 출력
		// => AJAX 기능을 이용하여 문서(comment_get.jsp)를 요청하여 댓글정보를 제공받아 출력 
		$.ajax({
			type: "POST",
			url: "comment_get.jsp",
			data: {"num":num},
			dataType: "xml",
			success: function(xmlDoc) {
				var code=$(xmlDoc).find("code").text();
				
				if(code=="success") {
					var comment=JSON.parse($(xmlDoc).find("data").text());
					
					$("#modify_writer").val(comment.writer);
					$("#modify_content").val(comment.content);
				} else {
					//댓글 변경영역을 숨기고 document 객체의 자식 엘리먼트로 이동
					$("#comment_update").hide().appendTo(document.documentElement);
					$("#message").html("댓글이 존재하지 않습니다.");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	}
	
	//[댓글변경]를 클릭한 경우 실행될 이벤트 핸들러 등록
	$("#modify_btn").click(function() {
		//댓글 엘리먼트에서 속성의 속성값으로 댓글번호를 반환받아 저장
		var num=$("#comment_update").parent().attr("num");
		//alert("num = "+num);
		
		var modify_writer=$("#modify_writer").val();
		if(modify_writer=="") {
			$("#modify_error").html("작성자를 입력해 주세요.");
			return;
		}
		
		var modify_content=$("#modify_content").val();
		if(modify_content=="") {
			$("#modify_error").html("댓글내용을 입력해 주세요.");
			return;
		}
		
		$("#modify_writer").val("");		
		$("#modify_content").val("");	
		$("#modify_error").html("");
		
		$("#comment_update").hide().appendTo(document.documentElement);

		//댓글정보를 변경하는 문서(comment_modify.jsp)를 요청하여 응답 처리
		$.ajax({
			type: "POST",
			url: "comment_modify.jsp",
			data: {"num":num,"writer":modify_writer,"content":modify_content},
			dataType: "xml",
			success: function(xmlDoc) {
				var code=$(xmlDoc).find("code").text();
				
				if(code=="success") {
					loadComment();
				} else {
					$("#message").html("댓글을 변경하지 못했습니다.");
				}
			}, 
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	});
	
	//[변경취소]를 클릭한 경우 실행될 이벤트 핸들러 등록
	$("#modify_cancel_btn").click(function() {
		$("#modify_writer").val("");		
		$("#modify_content").val("");	
		$("#modify_error").html("");
		
		$("#comment_update").hide().appendTo(document.documentElement);
	});
	
	//[삭제]를 클릭한 경우 호출되는 이벤트 핸들러 함수
	function removeComment(num) {
		$("#comment_update").hide().appendTo(document.documentElement);
		$("#comment_remove").show().appendTo("#comment_"+num);
	}
	
	//[댓글삭제]를 클릭한 경우 실행될 이벤트 핸들러
	$("#remove_btn").click(function() {
		var num=$("#comment_remove").parent().attr("num");
		$("#comment_remove").hide().appendTo(document.documentElement);

		//댓글을 삭제하는 문서(comment_remove.jsp)를 요청하여 응답받아 처리
		$.ajax({
			type: "POST",
			url: "comment_remove.jsp",
			data: {"num":num},
			dataType: "xml",
			success: function(xmlDoc) {
				var code=$(xmlDoc).find("code").text();
				
				if(code=="success") {
					loadComment();
				} else {
					$("#message").html("댓글을 삭제하지 못했습니다.");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	});
	
	//[삭제취소]를 클릭한 경우 실행될 이벤트 핸들러 등록
	$("#remove_cancel_btn").click(function() {
		$("#comment_remove").hide().appendTo(document.documentElement);
	});
	</script>	
</body>
</html>











