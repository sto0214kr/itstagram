<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Insert title here</title>
		
		<link href="${ pageContext.request.contextPath }/resources/style/sign_in.css" rel="stylesheet" type="text/css">
	</head>

	<body>
	
		<div id="main_box">
			<div id="signin_box">
				
					<!-- 메인 로고 시작 -->
					<div id="main_logo">
						<div class="logo_text">
							<span>ITstagram</span>
						</div>
					</div>
					<!-- 메인 로고 끝 -->
					
					<!-- 로그인 폼 시작 -->
					<div id="signin_form">
			
						<form action="" method="POST">
							<div class="col"><input name="id" placeholder="전화번호, 사용자 이름 또는 이메일"/></div>
							<div class="col"><input name="password" placeholder="비밀번호"/></div>
							
							<div class="form_btn">
								<input type="button" value="로그인" onclick="submitA(this.form);"/>
							</div>
						</form>
						
						<script type="text/javascript" src="/itstargram/resources/script/httpRequest.js"></script>
						<script type="text/javascript" src="/itstargram/resources/script/sign/signUp.js"></script>
				
					</div>
					<!-- 로그인 폼 끝 -->
													
			</div>
		</div>
						
		<!-- 가입하기 페이지 버튼 시작 -->
		<div id="signup_box">
			<div class="signup_info">
				계정이 없으신가요?
				<span><a href="sign_up.do">가입하기</a></span>
			</div>
		</div>
		<!-- 가입하기 페이지 버튼 끝 -->
		
		
		
		<script type="text/javascript" src="/itstargram/resources/script/httpRequest.js"></script>
		<script type="text/javascript" src="/itstargram/resources/script/sign/signIn.js"></script>
	</body>
</html>