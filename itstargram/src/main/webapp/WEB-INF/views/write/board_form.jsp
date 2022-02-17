<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style>
		body { margin:0px; padding:0px; }
		#board_form {
			margin: 0px auto;
			width: 1000px;
			float: left;
		}
		.image-container {
			float: left;
			display: inline-block;
		}
		.board_content {
			float: left;
			padding: 50px 25px;
		}
		.btn_upload {
			clear: both;
			height: 50px;
			font-size: 18px;
			padding-top: 10px;
			padding-right: 20px;
			text-align: right;
			border: 1px solid green;
		}
	</style>
	
	<script>
		function popupClose(f) {
			f.target = opener.name;
			
			f.submit();
			
			if(opener != null) {
				opener.view = null;
				
				self.close();
			}
		}
	</script>

</head>
<body>
	
	<h3 align="center">인스타그램 게시물 업로드 페이지</h3>
	
	<div id="board_form">
		<form method="post" name="writeform" target="board_list.do" action="board_insert.do">
			<div class="image-container">
			    <img style="width: 450px;" id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
			    <input style="display: block;" type="file" name="photos" id="input-image">
			</div>
			
			<div class="board_content">
				<textarea name="content" rows="20" cols="70"></textarea>
				
				<div class="btn_upload">
					<input type="submit" value="Upload" onclick="window.close()" size="3">
					<input type="button" value="창 닫기" onclick="window.close()">
				</div>
			</div>
			
			<!-- 로그인 후 session등의 곳에 저장된 member_num값 : 지금은 임의의 member_num 값 보냄 -->
			<input type="hidden" value="1" name="member_num">
			
		</form>
	</div>

	<script>
		// 파일 업로드 전 이미지 미리보기
		function readImage(input) {
		    // 인풋 태그에 파일이 있는 경우
		    if(input.files && input.files[0]) {
		        // 이미지 파일인지 검사 (생략)
		        // FileReader 인스턴스 생성
		        const reader = new FileReader()
		        // 이미지가 로드가 된 경우
		        reader.onload = e => {
		            const previewImage = document.getElementById("preview-image")
		            previewImage.src = e.target.result
		        }
		        // reader가 이미지 읽도록 하기
		        reader.readAsDataURL(input.files[0])
		    }
		}
		// input file에 change 이벤트 부여
		const inputImage = document.getElementById("input-image")
		inputImage.addEventListener("change", e => {
		    readImage(e.target)
		})
		
		// 업로드
		/* function send(f) {
			
			f.action = "board_insert.do";
			f.method = "post";
			f.submit();
		} */
	</script>

</body>
</html>