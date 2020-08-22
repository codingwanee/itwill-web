/* AJAX Module : 클래스(프로퍼티와 메소드)를 이용하여 AJAX 기능 제공 */
/* => 완전한 형태의 비동기식 요청에 대한 응답 처리를 제공 */
var site={};
site.itwill={};

//생성자 함수
site.itwill.Ajax=function(method, url, params, callback) {
	this.method=method;
	this.url=url;
	this.params=params;
	this.callback=callback;
	this.send();//메소드 호출 - Ajax 기능 제공
};

site.itwill.Ajax.prototype={
	//XMLHttpRequest 객체를 생성하여 반환하는 메소드
	getXMLHttpRequest:function() {
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
	},
	//XMLHttpRequest 객체를 이용하여 웹문서를 요청하기 위한 메소드
	send:function() {
		//XMLHttpRequest 객체를 반환받아 프로퍼티에 저장
		this.xhr=this.getXMLHttpRequest();
		
		//요청방식에 대한 유효성 검사 및 저장
		var httpMethod=this.method?this.method:"GET";
		if(httpMethod!="GET" && httpMethod!="POST") {
			httpMethod="GET";
		}
		
		//전달값에 대한 유효성 검사 및 저장
		var httpParams=(this.params==null||this.params=="")?null:this.params;
		
		//요청문서의 URL 주소 저장
		var httpUrl=this.url;
		
		//요청방식이 "GET"이고 전달값이 존재할 경우 요청문서의 URL 주소에 전달값을 QueryString으로 결합
		if(httpMethod=="GET" && httpParams!=null) {
			httpUrl=httpUrl+"?"+httpParams;
		}
		
		//응답결과를 제공받아 처리하는 함수 설정
		// => 외부함수에서 xhr 프로퍼티에 저장된 XMLHttpRequest 객체를 사용할 수 있도록 설정
		// => call() 함수를 이용하여 파라메터에 전달된 객체를 this 키워드로 사용
		var request=this;
		this.xhr.onreadystatechange=function() {
			request.onStateChange.call(request);
		}
		
		//웹문서 요청
		this.xhr.open(httpMethod, httpUrl);
		this.xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		this.xhr.send(httpMethod=="POST"?httpParams:null);
	},
	//외부함수(응답결과를 제공받아 처리하는 함수)를 호출하는 메소드
	onStateChange:function() {
		//외부함수 호출시 파라메터에 전달되는 XMLHttpRequest 객체를 일시적으로 변경
		// => 외부함수에서 XMLHttpRequest 객체를 변경해도 현재 모듈에 미영향
		this.callback(this.xhr);
	}
};