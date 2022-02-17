<%@page import="vo.MemberVO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
MemberVO vo = (MemberVO)request.getAttribute("vo");

int follower = vo.getFollowers().length;
int following = vo.getFollowings().length;
%>

<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8"/>
		<title>itstagram</title>
		
		<link rel="stylesheet" href="${ctxPath}/resources/style/profile.css"/>
		<script>let me_num = ${me.num}</script>
	</head>

	<body>
		<%@include file="../menu_bar.jsp" %>
		
		<div id="profile-home">
		<div class="header">
			<div class="box" id="profile">
				<div class="wrapper">
				
				<c:if test="${!empty vo.profile}">
					<img id="profile-img" alt="profile" src="${ctxPath}/client_resources/profile/${vo.num}/${vo.profile}"/>
				</c:if>
				
				<c:if test="${empty vo.profile}">
					<img id="profile-img" alt="profile" src="${ctxPath}/client_resources/profile/basic.jpg"/>
				</c:if>
					
					<c:if test="${vo.num eq me.num}">
						<label for="select-pf"></label>
						<input type="file" id="select-pf" onchange="changeProfile(this.files)"/>
					</c:if>
				</div>
			</div>
			
			<div class="box">
				<div class="wrapper">
					<div id="id">${vo.id}</div>
				
					<ul class="wrapper">
						<li class="button yes" id="edit-profile">프로필 편집</li>
						<li class="button no" id="message">메시지 보내기</li>
						<li class="button no" id="follow" onclick="follow(${vo.num}, true);">팔로우</li> <!-- .no/.yes: 팔로우 상태 구분  -->
						<li class="button no" id="recommaned">ㅁ</li>
					</ul>
					
					<div class="menu">⦁⦁⦁</div>
				</div>
				
				
				<ul class="wrapper">
					<li>게시물 <span id="post-num">${start}</span></li>
					<li>팔로워 <span id="follower-num" onclick="alertFollow('follower')"><%=follower%></span></li>
					<li>팔로우 <span id="following-num" onclick="alertFollow('following')"><%=following%></span></li>
				</ul>
				
				<div class="box">${vo.name}<a href="sign_out">&nbsp;&nbsp;&nbsp;&nbsp;로그아웃</a></div>
			</div>
		</div>
		
		<div class="body">
			<ul class="menu">
				<li class="selected">ㅁ 게시물</li>
				<li class="">ㅁ 저장됨</li>
				<li class="">ㅁ 태그됨</li>
			</ul>
			
			<div id="posts"></div>
		</div>
		
		<div class="footer">
			
		</div>	
		</div>
		
		<%@include file="../alert_follow.jsp" %>
		
		<%@include file="../alert_write.jsp"%>

		<%@include file="../alert_post.jsp"%>
		
		<script type="text/javascript" src="${ctxPath}/resources/script/httpRequest.js"></script>
		<script type="text/javascript" src="${ctxPath}/resources/script/util.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/resources/script/profile/profile.js"></script>
		
		<script type="text/javascript">
		let start = [${start}];
		
		window.onload = function() {
			check(${vo.num}, ${sessionScope.me.num});
			
			if(start[0] >= 1) updatePostList(${vo.num}, start);
			follow(${vo.num}, false);
		};

		window.addEventListener("scroll", function() {
			if(document.body.scrollHeight - window.scrollY === window.innerHeight) {
				if(start[0] >= 1) updatePostList(${vo.num}, start);
			}
		});
		
		function alertFollow(type) {
			let list = [];
			
			if(type === "follower") {
				<%for(int i = 0; i < vo.getFollowers().length; ++i) {%>
					list.push(<%=vo.getFollowers()[i]%>);
				<%}%>	
			} else if(type === "following") {
				<%for(int i = 0; i < vo.getFollowings().length; ++i) {%>
					list.push(<%=vo.getFollowings()[i]%>);
				<%}%>
			}
			
			Util.alertFollow(list, type);
		}
		
		function changeProfile(files) {
			console.log("changed!");
			let form = new FormData();
			form.append("num", ${me.num});
			form.append('files', files[0]);
			
			let httpRequest = new XMLHttpRequest();
			
			
			httpRequest.onload = function() {
				if(httpRequest.status == 200) {
					result_profile(httpRequest.responseText, files);
				}
			};
			
			httpRequest.open("POST", "upload_profile.do", true);
			// httpRequest.setRequestHeader("Content-Type", "multipart/form-data");
			httpRequest.send(form);
		}
		
		function result_profile(msg, files) {
			if(msg == "true") {
				let img = document.getElementById("profile-img");
				img.src = "/itstargram/client_resources/profile/" + ${vo.num} + "/" + files[0].name;
				console.log(files[0].name);
			}
		}
		
		let name = "${vo.name}";
		</script>
	</body>
</html>