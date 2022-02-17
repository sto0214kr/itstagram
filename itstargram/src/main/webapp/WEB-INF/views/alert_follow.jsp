<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="${ctxPath}/resources/style/alert.css"/>

<div class="container-follow-info" id="follow-alert" style="display:none">;
	<div class="background" onclick="document.getElementById('follow-alert').style.display = 'none'"></div> <!-- onclick="alert('hi')" -->
	
	<div class="wrapper">
		<div class="header_a">
			<span id="title_a">TEST_TITLE</span>
			<div id="close_a" onclick="document.getElementById('follow-alert').style.display = 'none'">×</div>
		</div>
		
		<div class="body_a">
			 <ul class="menu">
			 	<li class="menu selected">사람</li>
			 	<li class="menu">해시태그</li>
			 </ul>
			 
			 <ul class="list">
			 	<li>
			 		<div>
			 			<div id="profile_a">
				 			<img src="${ctxPath}/client_resources/profile/basic.jpg"/>
				 		</div>
				 		
				 		<div>
				 			<div id="id_a">TEST_ID</div>
				 			<div id="name_a">TEST_name</div>
				 		</div>
			 		</div>
			 		
			 		<div class="button" id="follow_a">팔로우</div>
			 	</li>
			 </ul>
		</div>
	</div>
</div>