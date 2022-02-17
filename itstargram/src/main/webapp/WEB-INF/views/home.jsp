<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8"/>
		<title>itstagram</title>
		
		<link rel="stylesheet" href="/itstargram/resources/style/home.css"/>
		<script type="text/javascript" src="/itstargram/resources/script/util.js"></script>
		<script type="text/javascript" src="/itstargram/resources/script/httpRequest.js"></script>
	</head>
	
	<body>
		<%@include file="menu_bar.jsp" %>
		
		<div id="homejsp">
		<div class="wrapper">
			<div class="left">				
				<ul class="list" id="post-list">

				</ul>
			</div>
			
			<div class="right">
				
			</div>
		</div>
		</div>
		
		<script type="text/javascript">
			let me_num = ${me.num};
			
			let start = [${start}];
			let timer = 0;
			
			window.onload = function() {
				if(start[0] >= 1) list(start);
			};
			
			window.addEventListener("scroll", function() {
				let dh = document.body.scrollHeight;
				
				if(window.innerHeight + window.scrollY >= dh - dh / 3 && timer === 0) {
					if(start[0] >= 1) list(start);
					timer = 1;
					
					setTimeout(() => {
						--timer;
					}, 1000);
				}
			});
			
			/* a.addEventListener("scroll", function() {
				console.log(a.scrollLeft, a.scrollWidth - a.clientWidth);
			}); */
			
			function move(num) {
				let width = a.scrollWidth - a.clientWidth;
				let pos = a.scrollLeft;
				
				let r = width / 100;
				a.scrollTo({left: 631.75 * (num - 1), beavior: 'smooth'});
			}
			
			function resize(obj) {
			    obj.style.height = '1px';
			    obj.style.height = (obj.scrollHeight - 50) + 'px';
			}
			
			// ====================
				
			
		</script>
		
		<script type="text/javascript" src="/itstargram/resources/script/home/home.js"></script>
		
		<%@include file="alert_write.jsp"%>

		<%@include file="alert_post.jsp"%>
	</body>
</html>