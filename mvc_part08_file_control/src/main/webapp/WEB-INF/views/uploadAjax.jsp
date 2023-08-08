<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.fileDrop{
		width:100%;
		height:200px;
		background-color:#ccc;
		border : solid 1px black;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h2>file drag &amp; drop</h2>
	<div class="fileDrop"></div>
	<div id="uplodedList">
		
	</div>
	
	<script>
		// 파일 인식 할려는 브라우저의 기본 이벤트 무시
		$(".fileDrop").on("dragenter dragover",(e)=>{
			e.preventDefault();
		});
		
		$(".fileDrop").on("drop",(e)=>{
			e.preventDefault();
			let files = e.originalEvent.dataTransfer.files;
			console.log(files);
			
			let formData = new FormData();
			
			for(let i = 0 ; i < files.length ; i++){
				let file = files[i];
				
				let maxSize = 10485760; // 10MB
				
				if(maxSize < file.size){
					alert('업로드 할수 없는 크기의 파일입니다.');
					return;
				}
				
				formData.append("files",file);
			}
			
			$.ajax({
				type : "POST",
				url : "uploadFiles",
				data : formData,
				processData : false,
				contentType : false,
				dataType : "json",
				success : (result) => {
					// upload 된 파일 이름 List
					console.log(result);
					let str = "";
					$(result).each(()=>{
						console.log(this);
						if(checkImageType(this)){
							console.log('이미지 파일');
						}else{
							console.log('일반 파일');
						}
					});
				}
				
			});
			
		});
		
		// 업로드된 파일이 이미지 파일인지 확인
		function checkImapgeType(fileName){
			let pattern = /jpg|jpge|gif|png/i;
			let result = fileName.match(pattern);
			console.log(result);
			
			/* 	
			let img = ['jpg','jpeg','png','gif'];
			for(let i = 0 ; i < img.length ; i++){
				if(fileName.toLowerCase().endsWith(img[i])){
					return true;
				}	
			}
			return false; 
			*/
			
			return result;
		}
	</script>
</body>
</html>