<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>COMMENT TEST</title>
<style>
	#comments li{
		list-style : none;
		padding : 10px;
		border : 1px solid #ccc;
		height : 150px;
		margin: 5px 0;
	}
	
	#modDiv{
		border : solid 1px black;
		padding : 10px;
		display : none;
	}
	
	#pagination li{
		list-style : none;
		float : left;
		padding : 3px;
		border : 1px solid skyblue;
		margin:3px;
	}
	
	#pagination li a{
		text-decoration : none;
		color:black;
	}
	
	#pagination li a.active{
		color:red;
	}
</style>
</head>
<body>
	<div id="modDiv">
		<!-- 수정할 댓글번호저장 -->
		<div id="modCno"></div>
		<div>
		<!-- 댓글 내용수정 -->
			<input type="text" id="modText" />
		</div>
		<div>
		<!-- 댓글 작성자 수정 -->
			<input type="text" id="modAuth"/>
		</div>
		<div>
			<button id="modBtn">MODIFY</button>
			<button id="delBtn">DELETE</button>
			<button id="closeBtn">CLOSE</button>
		</div>
	</div>
	<h2>AJAX - REST TEST</h2>
	<div>
		<div>
			comment author : <input type="text" id="cAuth" />
		</div>
		<div>
			comment content : <input type="text" id="cText" />		
		</div>
		<button id="addBtn">ADD COMMENT</button>
	</div>
	<div>
		<!-- 댓글리스트  -->
		<ul id="comments"></ul>
		
		<!-- 페이징 블럭 정보 -->
		<ul id="pagination"></ul>
		<br/><br/><br/><br/><br/><br/><br/><br/>
	</div>
	<script>
		var bno = 1;
		
		var page = 1;
		
		listPage(page);
		
		function listPage(page){
			$("#modDiv").css("display","none");
			$("body").prepend($("#modDiv"));
			let url = "comments/"+bno+"/"+page;
			$.getJSON(url,(data)=>{
				// data == Map
				// {'list' : {} , 'pm' : {} }
				console.log(data);
				printList(data.list);
				printPage(data.pm);
			});
		}
		
		function printPage(pm){
			let str = "";
			
			if(pm.prev) str += "<li><a href="+(pm.startPage - 1)+"> << </a></li>";
			
			for(let i = pm.startPage ; i <= pm.endPage ; i ++){
				if(pm.cri.page == i){
					str += "<li><a href="+i+" class='active'>"+i+"</a></li>";
				}else{
					str += "<li><a href="+i+">"+i+"</a></li>"
				}
			}
			
			if(pm.next) str += "<li><a href="+(pm.endPage + 1)+"> >> </a></li>";
			
			$("#pagination").html(str);
		}
		
		$("#pagination").on("click","li a",function(e){
			e.preventDefault();
			let commentPage = $(this).attr("href");
			listPage(commentPage);
		});
		
		
		// 전체 댓글 목록 호출
		function getCommentList(){
			let url = "comments/all/"+bno;
			// type == get
			// dataType= json
			$.getJSON(url,(data)=>{
				console.log(data);
				printList(data);
			});
		}
		
		// 검색된 댓글 목록을 출력할 함수
		function printList(list){
			let li;
			
			const elementsToRemove = document.querySelectorAll("#comments li");
			elementsToRemove.forEach((element) => {
			  element.remove();
			});
			
			list.forEach((item)=>{
				let str = "";
				li = document.createElement("li");
				let cno = item.cno;
				let cText = item.commentText;
				let cAuth = item.commentAuthor;
				str += cno+"-"+cAuth;
				str += `<button data-cno="\${cno}" data-text="\${cText}" data-auth="\${cAuth}">Modify</button>`;
				str += "<br/><hr/>"+cText;
				li.innerHTML = str;
				document.querySelector("#comments").append(li);	
			})
		}
		
		// 댓글 삽입 요청 처리
		$("#addBtn").click(()=>{
			let auth = $("#cAuth").val();
			let text = $("#cText").val();
			
			$.ajax({
				type : "post",
				url : "comments",
				data : {
					bno : bno,
					commentText : text,
					commentAuthor : auth
				},
				dataType : "text",
				success : (result)=>{
					alert(result);
					page = 1;
					listPage(page);
				},
				error : (res,status)=>{
					console.log(res),
					console.log(status)
				}
			})
		});
		
		$("#comments").on("click","li button",function(){
			console.log("click!");
			let cno = $(this).attr('data-cno');
			let text = $(this).attr('data-text');
			let auth = $(this).attr('data-auth');
			console.log(`\${cno}:\${text}:\${auth}`);
			
			$("#modCno").text(cno);
			$("#modText").val(text);
			$("#modAuth").val(auth);
			// display:block, display:none animation : toggle
			
			$(this).parent().after($("#modDiv"));
			
			$("#modDiv").toggle("slow");
			
		});
		
		// 댓글 수정 요청 modBtn click event
		$("#modBtn").click(()=>{
			let cno = $("#modCno").text();
			let text = $("#modText").val();
			let auth = $("#modAuth").val();
			
			$.ajax({
				type : "PATCH",
				url : "comments/"+cno,
				headers : {
					'Content-Type' : 'application/json'
				},
				data : JSON.stringify({
					commentAuthor : auth,
					commentText : text
				}),
				dataType : "text",
				success : (data) => {
					alert(data);
					$("#modDiv").slideUp("fast");
					// getCommentList();
					listPage(page);
				}
			})
		});
		
		// 수정창 닫기 Close modDiv
		$("#closeBtn").click(()=>{
			/*
				toggle == show() ,hide() 반복 실행
			  	fadeIn , fadeOut == opacity 투명도로 animation 효과 적용
	 			slideUp, slideDown == 위에서 아래로 , 아래에서 위로
	 		*/
			//	$("#modDiv").slideDown("slow"); 노출
			//  삭제
			$("#modDiv").slideUp("slow");
		});
		
		// 삭제 버튼 요청 처리
		$("#delBtn").click(()=>{
			let cno = $("#modCno").text();
			
			$.ajax({
				type : "DELETE",
				url : "comments/"+cno,
				dataType : "text",
				success : (result) => {
					alert(result);
					$("#modDiv").slideUp("slow");
					// getCommentList();
					listPage(page);
				}
			})
		});
	</script>
</body>
</html>