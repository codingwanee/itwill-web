function log(message) {
	var logE=document.getElementById("log");
	if(logE!=null) {
		logE.innerHTML+=message+"<br>";
	}
}