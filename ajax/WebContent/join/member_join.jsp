<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보를 입력받는 JSP 문서 --%>
<%-- => [회원가입]을 클릭한 경우 회원정보 저장 처리페이지(member_join_action.jsp)로 이동 : 입력된 회원정보 전달 --%>
<%-- => 처리페이지로 전달하기 전에 입력된 회원정보에 대한 유효성 검사 : 입력유무, 입력형식, 중복유무 등에 대한 검사 --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX</title>
<script type="text/javascript" src="/ajax/js/ajax.js"></script>
<style type="text/css">
.title {
	width: 100px;
	padding-right: 10px;
	text-align: center;
	font-weight: bold;
}

.input {
	width: 200px;
}

.message {
	width: 500px;
	color: red;
}

.msg {
	display: none;
}

#btn {
	text-align: center;
}
</style>
</head>
<body>
	<h1>회원가입</h1>
	<hr>
	<form action="member_join_action.jsp" method="post" id="joinForm">
	<table>
		<tr>
			<td class="title">아이디</td>
			<td class="input"><input type="text" name="id" id="id"></td>
			<td class="message">
				<div>
					<span id="idNullMsg" class="msg idMsg">아이디를 반드시 입력해 주세요.</span>				
					<span id="idValidMsg" class="msg idMsg">아이디를 형식에 맞게 입력해 주세요.</span>				
					<span id="idDuplMsg" class="msg idMsg">이미 사용중인 아이디입니다.</span>				
				</div>
			</td>
		</tr>
		<tr>
			<td class="title">비밀번호</td>
			<td class="input"><input type="password" name="passwd" id="passwd"></td>
			<td class="message">
				<div>
					<span id="passwdNullMsg" class="msg">비밀번호를 반드시 입력해 주세요.</span>				
					<span id="passwdValidMsg" class="msg">비밀번호를 형식에 맞게 입력해 주세요.</span>				
				</div>
			</td>
		</tr>
		<tr>
			<td class="title">이름</td>
			<td class="input"><input type="text" name="name" id="name"></td>
			<td class="message">
				<div>
					<span id="nameNullMsg" class="msg">이름을 반드시 입력해 주세요.</span>				
					<span id="nameValidMsg" class="msg">이름을 형식에 맞게 입력해 주세요.</span>				
				</div>
			</td>
		</tr>
		<tr>
			<td class="title">이메일</td>
			<td class="input"><input type="text" name="email" id="email"></td>
			<td class="message">
				<div>
					<span id="emailNullMsg" class="msg">이메일을 반드시 입력해 주세요.</span>				
					<span id="emailValidMsg" class="msg">이메일을 형식에 맞게 입력해 주세요.</span>				
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" id="btn">
				<button type="submit">회원가입</button>
			</td>
			<td></td>
		</tr>
	</table>
	</form>
	
	<script type="text/javascript">
	//아이디 중복 검사에 대한 결과를 저장하기 위한 전역변수
	// => false : 아이디 중복, true : 아이디 미중복 
	var idCheck=false;
	
	document.getElementById("id").focus();
	
	document.getElementById("joinForm").onsubmit=function() {
		//모든 메세지를 출력되지 않도록 설정 
		var msgList=document.querySelectorAll(".msg");
		for(i=0;i<msgList.length;i++) {
			msgList.item(i).style.display="none";
		}
		
		//입력값에 대한 유효성 검사 결과를 저장하기 위한 변수
		// => 변수에 false가 저장될 경우 서브밋 이벤트 중지 
		var result=true;
		
		//입력값에 대한 유효성 검사 - 입력유무, 입력형식, 중복유무
		var id=document.getElementById("id").value;
		var idReg=/^[a-zA-Z]\w{5,19}$/g;
		if(id=="") {
			document.getElementById("idNullMsg").style.display="block";
			result=false;
		} else if(!idReg.test(id)) {
			document.getElementById("idValidMsg").style.display="block";
			result=false;
		} else if(!idCheck) {
			document.getElementById("idDuplMsg").style.display="block";
			result=false;
		}
		
		var passwd=document.getElementById("passwd").value;
		var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
		if(passwd=="") {
			document.getElementById("passwdNullMsg").style.display="block";
			result=false;
		} else if(!passwdReg.test(passwd)) {
			document.getElementById("passwdValidMsg").style.display="block";
			result=false;
		}
		
		var name=document.getElementById("name").value;
		var nameReg=/^[가-힣]{2,10}$/g;
		if(name=="") {
			document.getElementById("nameNullMsg").style.display="block";
			result=false;
		} else if(!nameReg.test(name)) {
			document.getElementById("nameValidMsg").style.display="block";
			result=false;
		}
		
		var email=document.getElementById("email").value;
		var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
		if(email=="") {
			document.getElementById("emailNullMsg").style.display="block";
			result=false;
		} else if(!emailReg.test(email)) {
			document.getElementById("emailValidMsg").style.display="block";
			result=false;
		}
		
		return result;//false 반환될 경우 서브밋 이벤트 중지
	};
	
	//아이디 입력태그에서 촛점이 벗어난 경우 실행되는 이벤트 핸들러 함수 등록 
	document.getElementById("id").onblur=function() {
		var msgList=document.querySelectorAll(".idMsg");
		for(i=0;i<msgList.length;i++) {
			msgList.item(i).style.display="none";
		}
		
		var id=document.getElementById("id").value;
		var idReg=/^[a-zA-Z]\w{5,19}$/g;
		if(id=="") {
			document.getElementById("idNullMsg").style.display="block";
		} else if(!idReg.test(id)) {
			document.getElementById("idValidMsg").style.display="block";
		} else if(!idCheck) {
			document.getElementById("idDuplMsg").style.display="block";
		}
	}
	
	//아이디 입력태그에서 키보드 이벤트가 발생될 경우 실행된 이벤트 핸들러 함수 등록
	// => 아이디 중복 유무를 id_check.jsp 문서에 요청하여 응답 결과로 저장
	document.getElementById("id").onkeyup=function() {
		idCheck=false;
		
		var id=document.getElementById("id").value;
		if(id.length<6) return;
		
		new site.itwill.Ajax("POST", "id_check.jsp", "id="+id, function(xhr) {
			if(xhr.readyState==4) {
				if(xhr.status==200) {
					var xmlDoc=xhr.responseXML;
					
					var code=xmlDoc.getElementsByTagName("code").item(0).firstChild.nodeValue;
					if(code=="possible") {
						idCheck=true;
					}
				} else {
					alert("에러코드 = "+xhr.status);
				}
			} 
		});
	};
	</script>
</body>
</html>






