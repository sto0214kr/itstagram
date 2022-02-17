function submitA(form) {
	let email = form.email.value.trim();
	let name = form.name.value.trim();
	let id = form.id.value.trim();
	let password = form.password.value.trim();
	
	console.log(email, name, id, password);
	
	if(email === '') {
		// do something
		return;
	}
	
	if(id === '') {
		return;
	}
	
	if(password === '') {
		return;
	}
	
	let url = "sign_upA.do";
	let param = `email=${email}&name=${name}&id=${id}&password=${password}`;
	console.log(param);
	sendRequest(url, param, submit_result, "POST");
}

function submit_result(msg) {
	console.log(msg);
	if(msg === "no_email") {
		// do something
		return;
	} else if(msg === "no_id") {
		return;
	} else {
		location.href="profile.do?num=" + msg;
	}
}