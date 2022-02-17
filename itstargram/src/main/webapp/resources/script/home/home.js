function list(start) {
    let url = "home_update.do";
    let param = `start=${start[0]}`;

    sendRequest(url, param, list_result, "GET");
    console.log("hello, world!");
    start[0] -= 3;
}

function h_result(num) {
	return function(msg) {
		msg = msg.split("/");
		console.log("a");
		let li = document.getElementById(num + '');
		let hearts = li.getElementsByClassName("heart icon")[0];
		let img = hearts.getElementsByTagName("img")[0];
		img.src = "/itstargram/resources/img/heart_" + msg[0] + ".png";
		
		if(msg[1] !== "0") {
			let num = li.getElementsByClassName("hearts-num")[0];
			let span = num.getElementsByTagName("span")[0];
			num.style.display = "block";
			span.innerHTML = msg[1] + "개";
		} else {
			let num = li.getElementsByClassName("hearts-num")[0];
			num.style.display = "none";
		}
	};
}

function list_result(msg) {
	console.log(msg);
    let list = JSON.parse(msg);
    console.log(list);
    
    let parent = document.getElementById("post-list");
    
    for(let i = 0; i < list[1].length; ++i) {
		list[1][i].hearts = (list[1][i].hearts !== undefined ? list[1][i].hearts.split("/") : null);
	
	    let li = document.createElement("li");
	    li.id = list[1][i].num + '';
	    parent.appendChild(li);
	
	    let divTop = document.createElement("div");
	    divTop.className = "top";
	    li.appendChild(divTop);
	
	    let img = document.createElement("img");
	    if(list[0][list[1][i].member_num].profile == undefined) img.src = "/itstargram/client_resources/profile/basic.jpg";
	    else img.src = "/itstargram/client_resources/profile/" + list[0][list[1][i].member_num].num + "/" + list[0][list[1][i].member_num].profile;
	    divTop.appendChild(img);
	    
	    img.onclick = function() {
			location.href="profile.do?num=" + list[1][i].member_num;
		}
	
	    let span = document.createElement("span");
	    span.innerHTML = list[0][list[1][i].member_num].name;
	    divTop.appendChild(span);
	    
	    span.onclick = img.onclick;
	
	    let divMenu = document.createElement("div");
	    divMenu.className = "menu";
	    divMenu.innerHTML = "⦁⦁⦁";
	    divTop.appendChild(divMenu);
	    
	    // ==================================================
	    
	    let divImgs = document.createElement("div");
	    divImgs.className = "imgs";
	    li.appendChild(divImgs);
	    
	    let imgs = list[1][i].photos.split("/");
	    
	    for(let j = 0; j < imgs.length; ++j) {
			let divImg = document.createElement("div");
			divImg.className = "img";
			divImgs.appendChild(divImg);
			
			let img = document.createElement("img");
			img.src = "/itstargram/client_resources/post/" + list[1][i].num + "/" + imgs[j];
			divImg.appendChild(img);
		}
		
		let divBottom = document.createElement("div");
		divBottom.className = "bottom";
		li.appendChild(divBottom);
		
		let divBTop = document.createElement("div");
		divBTop.className = "b-top";
		divBottom.appendChild(divBTop);
		
		let divHeart = document.createElement("div");
		divHeart.className = "heart icon";
		divBTop.appendChild(divHeart);
		
		divHeart.onclick = function() {
			let link = "add_heart.do";
			let param = `num=${list[1][i].num}&member_num=${me_num}&type=true`;
			sendRequest(link, param, h_result(list[1][i].num), "POST");
		};
		
		img = document.createElement("img");
		divHeart.appendChild(img);
		
		let divComment = document.createElement("div");
		divComment.className = "comment icon";
		divBTop.appendChild(divComment);
		
		img = document.createElement("img");
		img.src = "/itstargram/resources/img/comment.png";
		divComment.appendChild(img);
		
		let divShare = document.createElement("div");
		divShare.className = "share icon";
		divBTop.appendChild(divShare);
		
		img = document.createElement("img");
		img.src = "/itstargram/resources/img/dm.png";
		divShare.appendChild(img);
		
		let divBookmark = document.createElement("div");
		divBookmark.className = "bookmark icon";
		divBTop.appendChild(divBookmark);
		
		img = document.createElement("img");
		img.src = "/itstargram/resources/img/bookmark.png";
		divBookmark.appendChild(img);
		
		// ==================================================
		
		let divFooter = document.createElement("div");
		divFooter.className = "footer";
		li.appendChild(divFooter);
		
		let divHeartsNum = document.createElement("div");
		divHeartsNum.className = "hearts-num";
		divFooter.appendChild(divHeartsNum);
		
		let b = document.createElement("b");
		b.innerHTML = "좋아요 ";
		divHeartsNum.appendChild(b);
		
		span = document.createElement("span");
		divHeartsNum.appendChild(span);
		
		let divContainer = document.createElement("div");
		divContainer.className = "container";
		divFooter.appendChild(divContainer);
		
		let spanNickname = document.createElement("span");
		spanNickname.className = "nickname";
		spanNickname.innerHTML = list[0][list[1][i].member_num].name;
		spanNickname.innerHTML += " ";
		divContainer.appendChild(spanNickname);
		
		spanNickname.onclick = function() {
			location.href = "profile.do?num=" + list[1][i].member_num;
		}
		
		let spanContent = document.createElement("span");
		spanContent.className = "content";
		spanContent.innerHTML = list[1][i].content;
		divContainer.appendChild(spanContent);
		
		let spanMore = document.createElement("span");
		spanMore.className = "more";
		spanMore.innerHTML = "...더보기";
		divContainer.appendChild(spanMore);
		
		if(spanContent.offsetHeight <= 20) spanMore.style.display = "none";
		
		divComment = document.createElement("div");
		divComment.className = "comment";
		
		function updateCommentNum() {
			Util.getCommentNum(list[1][i].num, 0).then(function(data) {
				if(data === "0") {
					divComment.style.display = "none";
				}
				
				divComment.style.display = "block";
				divComment.innerHTML = '댓글 <span class="comment-num">';
				divComment.innerHTML += data;
				divComment.innerHTML += '</span>개 모두 보기';
			});
		}
		
		updateCommentNum();

		divFooter.appendChild(divComment);
		
		
		
		divComment.onclick = function() {
			Util.alertPost(list[1][i], list[0][list[1][i].member_num].name);
		}
		
		let divDate = document.createElement("div");
		divDate.className = "date";
		divDate.innerHTML = "1월 27일";
		divFooter.appendChild(divDate);
		
		let divBox = document.createElement("div");
		divBox.className = "box";
		divFooter.appendChild(divBox);
		
		let textarea = document.createElement("textarea");
		textarea.name = "content";
		textarea.placeholder = "댓글 달기...";
		
		textarea.addEventListener("keydown", function() {
			resize(textarea);
		});
		
		textarea.addEventListener("keyup", function() {
			resize(this);
		});
		
		divBox.appendChild(textarea);
		
		let buttonPost = document.createElement("button");
		buttonPost.name = "post";
		buttonPost.innerHTML = "게시";
		divBox.appendChild(buttonPost);
		
		buttonPost.onclick = function() {
			let content = textarea.value;
			
			let link = "comment_add.do";
			let params = `member_num=${me_num}&ref_board=${list[1][i].num}&ref_comment=0&content=${content}`;
			sendRequest(link, params, null, "POST").then(function() {
				updateCommentNum();
			});
			
			textarea.value = "";
		}
		
		// ==================================================
		let link = "add_heart.do";
		let param = `num=${list[1][i].num}&member_num=${me_num}&type=false`;
		sendRequest(link, param, h_result(list[1][i].num), "POST");
	}
}







	