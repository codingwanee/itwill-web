/* AJAX Module : 전역변수와 함수를 이용하여 AJAX 기능 제공 */
var xhr=null;

function getXMLHttpRequest() {
	if(window.activeXObject) {
		try {
			return new ActiveXObject("msxml2.XMLHTTP");
		} catch (e) {
			try {
				return new ActiveXObject("MicrosoftXMLHTTP");
			} catch (e) {
				return null;
			}
		}
	} else if(window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else {
		return null;
	}
}

/* 요청과 응답 처리를 위한 함수 선언 */
function sendRequest(method, url, params, callback) {
	xhr=getXMLHttpRequest();
	
	//요청방식에 대한 유효성 검사 및 저장
	var httpMethod=method?method:"GET";
	if(httpMethod!="GET" && httpMethod!="POST") {
		httpMethod="GET";
	}
	
	//전달값에 대한 유효성 검사 및 저장
	var httpParams=(params==null||params=="")?null:params;
	
	//요청문서의 URL 주소 저장
	var httpUrl=url;
	
	//요청방식이 "GET"이고 전달값이 존재할 경우 요청문서의 URL 주소에 전달값을 QueryString으로 결합
	if(httpMethod=="GET" && httpParams!=null) {
		httpUrl=httpUrl+"?"+httpParams;
	}
	
	//응답결과를 제공받아 처리하는 함수 설정
	xhr.onreadystatechange=callback;
	
	//요청처리
	xhr.open(httpMethod, httpUrl);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send(httpMethod=="POST"?httpParams:null);
}









