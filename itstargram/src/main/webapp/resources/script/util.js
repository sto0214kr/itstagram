

let d = document;

let Util = {
	getVO: function(num) {
		let url = "get_vo.do";
		let param = `num=${num}`;
		
		return sendRequest(url, param, null, "GET");
	},
	
	alertFollow: function(list, type) {
		let title = d.getElementById("title_a");
		title.innerText = (type === "follower") ? "팔로워" : "팔로우";
		
		if(type === "follower") {
			let obj = d.getElementById("follow-alert").getElementsByClassName("menu")[0];
			obj.style.display = "none";
		}
		
		let obj = d.getElementById("follow-alert").getElementsByClassName("list")[0];
		obj.innerHTML = "";
		
		for(let i = 0; i < list.length; ++i) {
			Util.getVO(list[i]).then(function(data) {
				let vo = JSON.parse(data);
				
				let r = '<li class="' + vo.num + '">' +
					'<div>' +
						'<div id="profile_a">';
							if(vo.profile === undefined)
				 				r += '<img src="/itstargram/client_resources/profile/basic.jpg" onclick="location.href=\'profile.do?num=' + vo.num + '\'"/>';
				 			else
				 				r += '<img src="/itstargram/client_resources/profile/' + vo.num + '/' + vo.profile + '" onclick="location.href=\'profile.do?num=' + vo.num + '\'"/>';
				 				
				 		r += '</div>' +
				 		
				 		'<div>' +
				 			'<div id="id_a">' + vo.id + '</div>' +
				 			'<div id="name_a">' + vo.name + '</div>' +
				 		'</div>' +
					'</div>' +
					
					'<div class="button yes" id="follow_a" onclick="follow_2(' + vo.num +', true)">팔로잉</div>' +
				'</li>';
				
				obj.innerHTML += r;
			});
		}
		
		for(let i = 0; i < list.length; ++i) {
			let params = `num=${list[i]}&type=false`;
			
			let a = (function(vo) {
				return function(msg) {
					var btn = document.getElementsByClassName(vo + "")[0].getElementsByClassName("button")[0];
					
					
					btn.className = "button " + msg;
					btn.innerHTML = (msg == "yes" ? "팔로잉" : "팔로우");
					
					if(me_num === vo) btn.style.display = "none";
				}
			})(list[i]);
			
			sendRequest("follow.do", params, null, "GET").then(a);
		}
		
		d.getElementById("follow-alert").style.display = "block";
	},
	
	alertWrite: function() {
		let title = d.getElementById("title_a");
		title.innerText = "글쓰기";
		
		d.getElementById("write-alert").style.display = "block";
	},
	
	alertPost: function(vo, n) {
		let alert = document.getElementsByClassName("alert")[0]; // post;
		alert.style.display = "block";
		
		let imgs = document.getElementById("post").getElementsByClassName("imgs")[0];
		imgs.innerHTML = "";
		
		let imgList = vo.photos.split("/");
		
		for(let i = 0; i < imgList.length; ++i) {
			let li = document.createElement("li");
			li.innerHTML = "<img src='/itstargram/client_resources/post/" + vo.num + "/" + imgList[i] + "'/>";
			imgs.appendChild(li);
		}
		
		let link = "comment_list.do";
		let param = `ref_board=${vo.num}&ref_comment=0`;
		sendRequest(link, param, null, "POST").then(function(msg) {
			let list = JSON.parse(msg);
			 
			let li = document.getElementsByClassName("author")[0];
			
			let ta = document.getElementsByClassName("ta")[0];
			ta.ref_board = vo.num;
			
// ==================================================
			
			let parent = document.getElementById("contents");
			parent.innerHTML = "";
			
			let a = `<li class="author">
					<div class="content-author first">`;
						
						a += `<img src="/itstargram/client_resources/profile/basic.jpg"/>
						
						<div class="wrapper">
							<span class="name">${n}</span>
							<span class="content">${vo.content}</span>
						</div>
					</div>
					
					<div class="content-etc">
						<span class="date">2일</span>
					</div>
				</li>`;
				
			parent.innerHTML = a;
			
			for(let i = 0; i < list[0].length; ++i) {
				commentMaker(parent, list[0][i], list[1][list[0][i].member_num]);
			}
		});
	},
	
	getCommentNum: function(ref_board, num) {
		return sendRequest("comment_num.do", `ref_board=${ref_board}&ref_comment=${num}`, null, "POST");
	},
};

function commentMaker(parent, vo, name, type, p_vo) {
	li = document.createElement("li");
	li.className = vo.num;
	parent.appendChild(li);
	
		let div = document.createElement("div");
		div.className = "content-author";
		li.appendChild(div);
		
			let img = document.createElement("img");
			img.src = "/itstargram/client_resources/profile/basic.jpg";
			div.appendChild(img);
			
			let wrapper = document.createElement("div");
			wrapper.className = "wrapper";
			div.appendChild(wrapper);
			
				let span = document.createElement("span");
				span.className = "name";
				span.innerHTML = name;
				wrapper.appendChild(span);
				
				span = document.createElement("span");
				span.className = "content";
				span.innerHTML = vo.content;
				wrapper.appendChild(span);
		
		div = document.createElement("div");
		div.className = "content-etc";
		li.appendChild(div);
		
			span = document.createElement("span");
			span.className = "date";
			// span.innerHTML = list[0][i].regdate + "일";
			span.innerHTML = "2일";
			div.appendChild(span);
			
			span = document.createElement("span");
			span.className = "heart-num";
			if(vo.hearts > 0) span.innerHTML = vo.hearts + "개";
			else span.style.display = "none";
			div.appendChild(span);
			
			span = document.createElement("span");
			span.className = "reply-btn";
			span.innerHTML = "답글 달기";
			
			span.onclick = function() {
				let ta = document.getElementsByClassName("ta")[0];
				ta.value = "@" + name + " ";
				ta.focus();
				
				if(type != true) ta.ref_comment = vo.num;
				else ta.ref_comment = p_vo.num;
			};
			
			div.appendChild(span);
			
			if(type != true) {
				let ul = document.createElement("ul");
				ul.className = "re-replies";
				div.appendChild(ul);
				
				function result_c(ul) {
					return function(data) {
						let li = document.createElement("li");
						li.className = "placeholder closed";
						li.innerHTML = "hello";
						
						if(data === "0") {
							ul.style.display = "none";
						}
						
						li.innerHTML = "――&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;답글 보기(<span class='cmt-num'>" + data + "</span>개)";
						
						li.onclick = function() {
							if(li.className == "placeholder closed") {
								li.innerHTML = "――&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;답글 숨기기";
								
								let param = `ref_comment=${vo.num}&ref_board=${vo.ref_board}`;
								sendRequest("comment_list.do", param, null, "POST").then(function(msg) {
									let list = JSON.parse(msg);
									
									for(let i = 0; i < list[0].length; ++i) {
										commentMaker(ul, list[0][i], list[1][list[0][i].member_num], true, vo);
									}
								});
								
								li.className = "placeholder opened";
							} else {
								let list = ul.getElementsByTagName("li");
								let liArr = [];
								
								li.innerHTML = "――&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;답글 보기(<span class='cmt-num'>" + (list.length - 1) + "</span>개)";
								li.className = "placeholder closed";

								for(let i = 1; i < list.length; ++i) {
									liArr.push(list[i]);
								}
								
								for(let i = 0; i < liArr.length; ++i) {
									liArr[i].remove();
								}
							}
						};
						
						ul.appendChild(li);
					};
				}
				
				Util.getCommentNum(vo.ref_board, vo.num).then(result_c(ul));
			}
}