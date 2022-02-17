<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/itstargram/resources/style/alert_post.css"/>

<div class="alert" id="post" style="display: none;">
	<div id="close-btn" onclick = "document.getElementById('post').style.display = 'none'">×</div>
	<div id="background" onclick = "document.getElementById('post').style.display = 'none'"></div>
	
	<div class="container">
		<div class="left">
			<ul class="imgs">
				<li>
					<img src="/itstargram/client_resources/profile/basic.jpg"/>
				</li>
			</ul>
		</div>
		
		<div class="right">
			<div id="profile">
				<img src="/itstargram/client_resources/profile/basic.jpg"/>
				<span>test_id</span>
			</div>
			
			<ul id="contents">
				<li class="author">
					<div class="content-author first">
						<img src="/itstargram/client_resources/profile/basic.jpg"/>
						
						<div class="wrapper">
							<span class="name">test_id</span>
							<span class="content">test_content</span>
						</div>
					</div>
					
					<div class="content-etc">
						<span class="date">2일</span>
					</div>
				</li>
				
				<li>
					<div class="content-author">
						<img src="/itstargram/client_resources/profile/basic.jpg"/>
						
						<div class="wrapper">
							<span class="name">test_id</span>
							<span class="content">test_content</span>
						</div>
					</div>
					
					<div class="content-etc">
						<span class="date">2일</span>
						<span class="heart-num">좋아요 500개</span>
						<span class="reply-btn">답글 달기</span>
						
						<ul class="re-replies">
							<li class="placeholder">――&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;답글 보기(10개)</li>
						</ul>
					</div>
				</li>
			</ul>
			
			<div class="bottom">
				<div class="wrapper menu">
					<div class="heart"><img src="/itstargram/resources/img/heart_false.png"/></div>
					<div class="comment"><img src="/itstargram/resources/img/comment.png"/></div>
					<div class="share"><img src="/itstargram/resources/img/dm.png"/></div>
				</div>
				
				<div class="wrapper content">
					<span class="heart-num">좋아요 10개</span>
					<span class="date">2일 전</span>
				</div>
				
				<div class="wrapper comment" >
					<textarea class="ta" placeholder="댓글 달기..." onkeydown="resize2(this)" onkeyup="resize2(this)"></textarea>
					<div class="submit" onclick = "submit()">게시</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
let ta = document.getElementsByClassName("ta")[0];
ta.ref_board = 0, ta.ref_comment = 0;

function resize2(obj) {
    obj.style.height = '1px';
    obj.style.height = (obj.scrollHeight - 35) + 'px';
}

function submit() {
	console.log(ta.ref_board, ta.ref_comment, me_num, ta.value);
	let param = "member_num=" + me_num + "&ref_board=" + ta.ref_board + "&ref_comment=" + ta.ref_comment + "&content=" + ta.value;
	
	sendRequest("comment_add.do", param, null, "POST").then(function(data) {
		let vo = JSON.parse(data);
		
		if(ta.ref_comment != 0) {
			let ul = document.getElementsByClassName(vo.ref_comment + "")[0].getElementsByClassName("re-replies")[0];
			console.log(ul);
			ul.style.display = "block";
			
			let li = ul.getElementsByClassName("cmt-num")[0];
			li.innerHTML = (parseInt(li.innerHTML) + 1) + "";
			
			commentMaker(ul, vo, "${me.name}");
		} else {
			let ul = document.getElementById("contents");
			commentMaker(ul, vo, "${me.name}");
		}
		
		ta.ref_comment = 0;
	});
	
	ta.value = "";
}
</script>