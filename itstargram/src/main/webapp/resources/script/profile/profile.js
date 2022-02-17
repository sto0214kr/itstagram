function check(me, target) {
	let buttons = document.getElementsByClassName("button");
	if(target == me) {
		for(let i = 1; i < buttons.length; ++i) {
			buttons[i].style.display = "none";
		}
	} else {
		buttons[0].style.display = "none";
	}
}

function updatePostList(num, start) {
	let url = "profile_update.do";
	let param = `num=${num}&start=${start[0]}`;
	
	sendRequest(url, param, updatePostList_result, "GET");
	start[0] -= 9;
}

function updatePostList_result(msg) {
	let list = eval(msg);
	
	let parent = document.getElementById("posts");
	
	for(let i in list) {
		let photo = (list[i].photos).split("/")[0];
		console.log(photo);
		
		/*parent.innerHTML += ('<div class="box">' +
				'<img src="/itstargram/client_resources/post/' + list[i].num + '/' + photo + '"/>' +
			'</div>');*/
			
		let box = document.createElement("div");
		box.className = "box";
		box.innerHTML = '<img src="/itstargram/client_resources/post/' + list[i].num + '/' + photo + '"/>';
		box.onclick = function() {
			console.log(list[i].num);
			Util.alertPost(list[i], name);
		};
		
		parent.appendChild(box);
	}
}

function follow(num, type) {
	let url = "follow.do";
	let param = `num=${num}&type=${type}`;
	
	sendRequest(url, param, follow_result(type), "GET");
}

function follow_2(num, type) {
	let url = "follow.do";
	let param = `num=${num}&type=${type}`;
	
	sendRequest(url, param, follow_result2(num, type), "GET");
}

function follow_result(type) {
	return (function(msg) {
		if(msg === "sign_in") {
			location.href="sign_in.do";
			return;
		} // 로그인 화면 띄우기
			
		let status = "no";
		status = (msg === "no" && type) ? "yes" : "no"; 
		
		let buttons = document.getElementsByClassName("button");
		
		if(msg === "yes") buttons[1].style.display = "block";
		else buttons[1].style.display = "none";
		
		for(let i = 1; i < buttons.length; ++i) {
			buttons[i].classList.replace(status, msg);
		}
	});
}

function follow_result2(num, type) {
	return (function(msg) {
		if(msg === "sign_in") {
			location.href="sign_in.do";
			return;
		} // 로그인 화면 띄우기
			
		let status = msg; 
		
		var btn = document.getElementsByClassName(num + "")[0].getElementsByClassName("button")[0];
		
		btn.className = "button " + status;
		btn.innerHTML = (status === "yes") ? "팔로잉" : "팔로우";
		
	});
}