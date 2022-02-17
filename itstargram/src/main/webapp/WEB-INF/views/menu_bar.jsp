<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="${ pageContext.request.contextPath }/resources/style/menu_bar.css" rel="stylesheet" type="text/css">

<div style = "width: 100%; height: 100px;">

</div>
	<div id="menu_bar_box">
		<div id="menu_bar">
		
			<!-- 로고 시작 -->
			<div id="main_logo">
				<div class="logo_text">
					<span>ITstagram</span>
				</div>
			</div>
			<!-- 로고 끝 -->
			
			<!-- 검색 부분 시작 -->
			<div id="search_box">
				<div class="search_input">
					<input name="search" value="&nbsp;&nbsp;&nbsp;검색">
				</div>
			</div>
			<!-- 검색 부분 끝 -->
			
			<!-- 메뉴 : 페이지 이동 버튼  시작 -->
			<div id="menu_btn_box">
				<div class="menu_btn">
					<ul>
						<li>
							<a href="home.do">
								<img src="${ pageContext.request.contextPath }/resources/img/home.png">
							</a>
						</li>
						<li>
							<a href="dm.do">
								<img src="${ pageContext.request.contextPath }/resources/img/direct.png">
							</a>
						</li>
						<li>
							<a href="#" onmouseover="info_over(event);" onmouseout="info_out();" onclick = "Util.alertWrite()">
								<img src="${ pageContext.request.contextPath }/resources/img/upload.png">								
							</a>
						</li>
						<li>
							<a href="#">
								<img src="${ pageContext.request.contextPath }/resources/img/recommend.png">
							</a>
						</li>
						<li>
							<a href="#">
								<img src="${ pageContext.request.contextPath }/resources/img/hearts.png">
							</a>
						</li>
						<li>
							<a href="profile.do?num=${me.num}">
								<img src="${ pageContext.request.contextPath }/resources/img/mypage.png">
							</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- 메뉴 : 페이지 이동 버튼  끝 -->
			
		</div>
		
		<!-- 마우스 오버 이벤트 시작 -->
		<div id="upload_info">
			<div class="info_text">
				이제 컴퓨터에서 직접 게시물을 만들어 공유할 수 있습니다.
			</div>
		</div>
		<!-- 마우스 오버 이벤트 끝 -->
		
	</div>
	
	<script>
		// 마우스 오버 -> 게시물 업로드 안내
		function info_over(event) {
			
			var x = event.clientX - 320;
			var y = event.clientY + 10;
			
			document.getElementById("upload_info").style.visibility = "visible";
			document.getElementById("upload_info").style.left = x + "px";
			document.getElementById("upload_info").style.top = y + "px";
		}
		
		// 마우스 아웃
		function info_out() {
			document.getElementById("upload_info").style.visibility = "hidden";
		}
	</script>