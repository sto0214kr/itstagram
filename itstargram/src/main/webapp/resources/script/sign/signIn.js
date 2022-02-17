function submitA(form) {
	let id = form.id.value.trim();
	let password = form.password.value.trim();
	
	if(id === '') {
		return;
	}
	
	if(password === '') {
		return;
	}
	
	let url = "sign_inA.do";
	let param = `id=${id}&password=${password}`;
	console.log(param);
	sendRequest(url, param, submit_result, "POST");
}

function submit_result(msg) {
	console.log(msg);
	if(msg === "no_id") {
		// do something
		return;
	} else if(msg === "no_pwd") {
		return;
	} else {
		location.href="profile.do?num=" + msg;
	}
}