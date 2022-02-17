let webSocket = new WebSocket("ws://localhost:8080/itstargram/chatserver");

webSocket.onopen = function(message) {
	webSocket.onopen = function(message) {
		
	};
	
	// WebSocket 서버와 접속이 끊기면 호출되는 함수
	webSocket.onclose = function(message) {
	// 콘솔 텍스트에 메시지를 출력한다.
	};
	
	// WebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수
	webSocket.onerror = function(message) {
	// 콘솔 텍스트에 메시지를 출력한다.
	};
	
	/// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
	webSocket.onmessage = function(message) {
	// 콘솔 텍스트에 메시지를 출력한다.
		console.log(message.data);
	};
	
	(function() {
		webSocket.send("{'num': 1, 'type': 'connect', 'data': [1]}");
		webSocket.send("{'num': 1, 'type': 'link', 'data': [1, 2]}");
		webSocket.send("{'num': 1, 'type': 'chat', 'data': ['Hello, world!']}");
	})();
};