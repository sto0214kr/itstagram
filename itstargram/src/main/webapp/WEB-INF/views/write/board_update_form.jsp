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
		.menu_bar {
			width: 20px;
			clear: both;
			float: right;
			padding-right: 30px;
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
		#plus {
			width: 60px;
			height: 60px;
			position: absolute;
			padding-top: 10px;
			padding-left: 7px;
			visibility: hidden;
		}
	</style>
	
	<script>
		// 더보기 메뉴
		function plus() {
			var x = event.clientX;
			var y = event.clientY;
			
			document.getElementById("plus").style.visibility = "visible";
			document.getElementById("plus").style.left = x + "px";
			document.getElementById("plus").style.top = y + "px";
			
			// 다음에 오는 명령을 멈춰라 
			event.preventDefault();
		}
		
		// 더보기 폼 숨기기		
		function plus_hide() {
			document.getElementById("plus").style.visibility = "hidden";
		}
		document.onclick = plus_hide();
		
		// 수정
		function modify(f) {
			
			var num = f.num.value;
			
			if(!confirm("수정을 완료 하시겠습니까?")) {
				return;
			}
			
			f.action = "board_update.do?num=" + num;
			f.method = "post";
			f.submit();
		}
		
		// 삭제
		function del(f) {
			
			var num = f.num.value;
			
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			f.action = "board_delete.do?num=" + num;
			f.method = "post";
			f.submit();
		}
	</script>

</head>
<body>
	
	<h3 align="center">인스타그램 게시물 수정 페이지</h3>
	
	<div id="board_form">
		<form>
			<div>
				<img class="menu_bar" src="${ pageContext.request.contextPath }/resources/menu_bar.png" onclick="plus();">
			</div>
		
			<div class="image-container">
			    <img style="width: 450px;" id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
			    <input style="display: block;" type="file" name="photos" id="input-image" value="${ vo.photos }">
			</div>
			
			<div class="board_content">
				<textarea name="content" rows="20" cols="70">${ vo.content }</textarea>
				
				<div class="btn_upload">
					♡ : ${ vo.hearts } <br>
					${ vo.regdate }
				</div>
			</div>
			
			<!-- 더보기 메뉴 폼 시작 -->
			<div id="plus" onclick="event.preventDefault();">
				<input type="hidden" value="${ vo.num }" name="num">
			
				<div><input type="button" value="수정" onclick="modify(this.form);"></div>
				<div><input type="button" value="삭제" onclick="del(this.form);"></div>
			</div>
			<!--더보기 메뉴 폼 끝 -->
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
		function send(f) {
			
			f.action = "board_insert.do";
			f.method = "post";
			f.submit();
		}
	</script>

</body>
</html>