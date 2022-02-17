function sendRequest(url, param, callback, method) {
	method = (method.toUpperCase() == "GET") ? "GET" : "POST";
	param = (param == null) ? '' : param;
	url = (method == "GET") ? url + "?" + param : url;
	
	return new Promise(function(resolve, reject) {
		let httpRequest = new XMLHttpRequest();
	
		httpRequest.onload = function() {
			if(httpRequest.status == 200) {
				if(callback !== null) callback(httpRequest.responseText);
				resolve(httpRequest.responseText);
			}
		};
		
		httpRequest.open(method, url, true);
		httpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		httpRequest.send(method == "POST" ? param : null);
	});
}

function makeParam(params) {
	let result = "";
	
	for(let i in params) {
		result += params[i].name + "=" + params[i].value + "&"; 
	}
	
	return result.substring(0, result.length - 1);
}