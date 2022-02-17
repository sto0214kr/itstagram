<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8"/>
		<title>itstargram</title>
		
		<link rel="stylesheet" href="${ctxPath}/resources/style/dm.css"/>
	</head>
	
	<body>
		<div class="body">
			<div class="container left">
				<div class="top">
					<div class="wrapper">
						<span id="id">test_id</span>
						<div id="menu">ㅁ</div>
					</div>
					
					<div id="write">ㅇ</div>
				</div>
				
				<ul id="list">
					<li>
						<div id="profile"><img src="${ctxPath}/client_resources/profile/basic.jpg"/></div>
						<div id="info">
							<span id="name">test님</span>
							<div class="wrapper">
								<span id="msg">최근 메시지</span> ·
								<span id="date">2일</span>
							</div>
						</div>
					</li>
					
					<li>
						<div id="profile"><img src="${ctxPath}/client_resources/profile/basic.jpg"/></div>
						<div id="info">
							<span id="name">test님</span>
							<div class="wrapper">
								<span id="msg">최근 메시지</span> ·
								<span id="date">2일</span>
							</div>
						</div>
					</li>
					
					<li>
						<div id="profile"><img src="${ctxPath}/client_resources/profile/basic.jpg"/></div>
						<div id="info">
							<span id="name">test님</span>
							<div class="wrapper">
								<span id="msg">최근 메시지</span> ·
								<span id="date">2일</span>
							</div>
						</div>
					</li>
					
					<li>
						<div id="profile"><img src="${ctxPath}/client_resources/profile/basic.jpg"/></div>
						<div id="info">
							<span id="name">test님</span>
							<div class="wrapper">
								<span id="msg">최근 메시지</span> ·
								<span id="date">2일</span>
							</div>
						</div>
					</li>
					
					<li>
						<div id="profile"><img src="${ctxPath}/client_resources/profile/basic.jpg"/></div>
						<div id="info">
							<span id="name">test님</span>
							<div class="wrapper">
								<span id="msg">최근 메시지</span> ·
								<span id="date">2일</span>
							</div>
						</div>
					</li>
				</ul>
			</div>
			
			<div class="container right">
				<div class="top">
					<div class="wrapper">
						<div id="profile"><img src="${ctxPath}/client_resources/profile/basic.jpg"/></div>
						<div id="name">test님</div>
					</div>
					
					<div id="info">ㅇ</div>
				</div>
				
				<ul id="list">
					<li class="left">
						<span class="content">ㅎㅇ</span>
					</li>
					
					<li class="left">
						<span class="content">ㅎㅇ</span>
					</li>
					
					<li class="left end">
						<div id="profile"><img src="${ctxPath}/client_resources/profile/basic.jpg"/></div>
						<span class="content">ㅎㅇasdfasdfasdf</span>
					</li>
					
					<li class="date">
						2022년 1월 1일 호우 10:03
					</li>
					
					<li class="right">
						<span class="content">ㅎㅇ</span>
					</li>
					
					<li class="right">
						<span class="content">ㅎㅇ</span>
					</li>
					
					<li class="right">
						<span class="content">ㅎㅇ</span>
					</li>
				</ul>
			</div>
		</div>
		
		<script type="text/javascript" src="${ctxPath}/resources/script/dm/dm.js"></script>
	</body>
</html>