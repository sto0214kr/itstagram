<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${ctxPath}/resources/style/alert_write.css"/>
<link rel="stylesheet" href="${ctxPath}/resources/style/alert.css"/>
	
<div class="container-follow-info" id="write-alert" style="display:none;">
	<div id="close-btn" onclick = "document.getElementById('write-alert').style.display = 'none'">×</div>
	<div class="background" onclick="document.getElementById('write-alert').style.display = 'none'"></div> <!-- onclick="alert('hi')" -->
	
	<div class="wrapper">
		<div class="header_a">
			<span id="title_a">TEST_TITLE</span>
			<div id="send_a" onclick="uploadPost()">공유하기</div>
		</div>
		
		<div class="body_a">
			 <div class="left">
			 	<!-- <div class="btns">
	 				<div class="right-btn"></div>
	 				<div class="left-btn"></div>
	 			</div> -->
	 			
			 	<div class="imgs" style="display: none">
			 		<!-- <div class="img"><img src="/itstargram/client_resources/profile/basic.jpg"/></div>
			 		<div class="img"><img src="/itstargram/client_resources/profile/basic.jpg"/></div>
			 		<div class="img"><img src="/itstargram/client_resources/profile/basic.jpg"/></div> -->
			 	</div>
			 	
			 	<span>사진과 동영상을 여기에 끌어다 놓으세요</span>
			 	
		 		<label for="upload">컴퓨터에서 선택</label>
	 			<input id="upload" type="file" name="photos" class="button" multiple onchange="uploadF(this.files);"/>
			 </div>
			 
			 <div class="right" style="display: none">
			 	<div class="profile">
			 		<div class="img"><img src="/itstargram/client_resources/profile/basic.jpg"/></div>
			 		<span>${me.name }</span>
			 	</div>
			 	
			 	<textarea id="content_a" placeholder="문구 입력..."></textarea>
			 </div>
		</div>
	</div>
</div>

<script>
let index = 0;
let randomNum = 0;
let list_L = "";

function uploadF(files) {
	let form = new FormData();
	form.append("num", randomNum = Math.floor(Math.random() * 10000));
	for(; index < files.length; ++index) {
		form.append('files', files[index]);
		console.log(files[index].name);
	}
	
	let httpRequest = new XMLHttpRequest();
	
	
	httpRequest.onload = function() {
		if(httpRequest.status == 200) {
			if(call_back !== null) call_back(httpRequest.responseText, files);
		}
	};
	
	httpRequest.open("POST", "upload_photo.do", true);
	// httpRequest.setRequestHeader("Content-Type", "multipart/form-data");
	httpRequest.send(form);
}

function uploadPost() {
	let content = document.getElementById("content_a").value;
	console.log(content);
	
	sendRequest("upload_post.do", "content=" + content + "&member_num=" + ${me.num} + "&num=" + randomNum + "&list=" + list_L, null, "POST")
	.then(function() {
		location.reload();
	});
	
	document.getElementById('write-alert').style.display = 'none';
}

function call_back(msg, files) {
	list_L = "";
	let parent = document.getElementById("write-alert").getElementsByClassName("imgs")[0];
	parent.style.display = "block";
	parent.innerHTML = "";
	
	let before_btn = document.createElement("div");
	before_btn.className = "before_btn";
	before_btn.innerHTML = "<";
	parent.appendChild(before_btn);
	
	let after_btn = document.createElement("div");
	after_btn.className = "after_btn";
	after_btn.innerHTML = ">";
	parent.appendChild(after_btn);
	
	for(let i = 0; i < files.length; ++i) {
		let divImg = document.createElement("div");
		divImg.className = "img";
		parent.appendChild(divImg);
		
		let img = document.createElement("img");
		img.src = "/itstargram/client_resources/post/" + randomNum + "/" + files[i].name;
		list_L += files[i].name + "/";
		divImg.appendChild(img);
	}
	
	let divRight = document.getElementById("write-alert").getElementsByClassName("right")[0];
	divRight.style.display = "block";
}

function move2(num) {
	let a = document.getElementById("write-alert").getElementsByClassName("imgs")[0];
	let width = a.scrollWidth - a.clientWidth;
	let pos = a.scrollLeft;
	
	let r = width / 100;
	a.scrollTo({left: 400 * (num - 1), beavior: 'smooth'});
}
</script>