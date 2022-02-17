<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style>
		#main_box {
			width: 1000px;
		}
		.box_one {
			border: 1px solid gray;
			width: 280px;
			margin-top: 30px;
			margin-right: 10px;
			padding: 20px;
			float: left;
		}
		.img_box {
			width: 250px;
			height: 250px;
			margin-top: 40px;
			border: 1px solid gray;
		}
		.img_box img {
			width: 250px;
			height: 250px;
		}
		.col {
			text-align: left;
			margin: 10px auto;
			margin-left: 10px;
			width: 240px;
		}
	</style>
	
	<script type="text/javascript">		
		var openWin;
		function viewPopup() {
						
			window.name = "board_list.do";
			openWin = window.open("board_form.do", "view", "width=870, height=500, resizable = no, scrollbars = no, status = no");

		}
	</script>
	
</head>
<body>
	
	<h3 align="center">인스타그램 게시물 전체 목록</h3>
		<div id="main_box" align="center">
			<div>
				<input type="button" value="UPLOAD" onclick="viewPopup();">
			</div>
			
			<form>
			<c:forEach var="vo" items="${ list }">
			
				<div class="box_one">
				
					<div class="img_box">
						<c:if test="${ vo.photos ne 'no_file' }">
							<a href="board_update_form.do?num=${ vo.num }">photos<img src=""></a>
							</c:if>
						
						<c:if test="${ vo.photos eq 'no_file' }">
							<a onclick="setChildText();" href="board_update_form.do?num=${ vo.num }"><img src="${ pageContext.request.contextPath }/resources/no_img.jfif"></a>
						</c:if>
					</div>
					
					<div class="col">
						♡ : ${ vo.hearts }
					</div>
					
					<div class="">
						<textarea rows="5" cols="40">${ vo.content }</textarea>
					</div>
					
				</div>
				
				<!-- 전달값 -->
				<input type="hidden" value="${ vo.num }" name="num" id="num">
			</c:forEach>
			</form>
			
		</div>
</body>
</html>