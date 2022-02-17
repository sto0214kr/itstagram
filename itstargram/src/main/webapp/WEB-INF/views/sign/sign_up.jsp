<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Insert title here</title>
		
		<link href="${ pageContext.request.contextPath }/resources/style/sign_up.css" rel="stylesheet" type="text/css">
	</head>

	<body>
		<div id="main_box">
			<div id="signup_box">
			
				<!-- 메인 로고 시작 -->
				<div id="main_logo">
					<div class="logo_text">
						<span>ITstagram</span>
					</div>
				</div>
				<!-- 메인 로고 끝 -->
				
				<!-- 회원가입 폼 시작 -->
				<div id="signup_form">
					<h3 class="form-text">친구들의 사진과 동영상을 보려면 가입하세요.</h3>
		
					<form action="" method="POST">
						<div class="col"><input name="email" placeholder="이메일 주소"/></div>
						<div class="col"><input name="name" placeholder="성명"/></div>
						<div class="col"><input name="id" placeholder="사용자 이름"/></div>
						<div class="col"><input name="password" placeholder="비밀번호"/></div>
						
						<div class="form_btn">
							<input type="button" value="가입" onclick="submitA(this.form);"/>
						</div>
					</form>
					
					<script type="text/javascript" src="/itstargram/resources/script/httpRequest.js"></script>
					<script type="text/javascript" src="/itstargram/resources/script/sign/signUp.js"></script>
			
				</div>
				<!-- 회원가입 폼 끝 -->
												
			</div>
						
		</div>
						
		<!-- 로그인 페이지 버튼 시작 -->
		<div id="login_box">
			<div class="login_info">
				계정이 있으신가요?
				<span><a href="sign_in.do">로그인</a></span>
			</div>
		</div>
		<!-- 로그인 페이지 버튼 끝 -->
			
		
	</body>
</html>