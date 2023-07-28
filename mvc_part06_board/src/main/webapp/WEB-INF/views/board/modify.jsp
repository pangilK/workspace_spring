<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify.jsp</title>
<style>
	#box{
		border : solid 0px;
		width : 300px;
		height : 200px;
		margin : auto;
	}
	#box div{height:30px; margin-bottom:15px;}
	#title{height:10px;}
	#writer{margin-top:45px;}
	label{float:left;}
	textarea,input{float:right; width:155px;}
	#submit{
	    display: flex;
    	margin: auto;
    	flex-wrap: wrap;
    	align-content: stretch;
    	justify-content: space-evenly;
    };
</style>
</head>
<body>
	<div id="box">
		<h3>MODIFY BAORD</h3>
		<!-- model boardVO -->
		<!-- board/modify POST -->
		<form action="modify" method="POST">
			<input type="hidden" name="bno" value="${boardVO.bno}"/>
			<div id="title">
				<label>TITLE</label>
				<input type="text" name="title" value="${boardVO.title}" />
			</div>
			<div>
				<label>CONTENT</label>
				<textarea name="content" rows=3>${boardVO.content}</textarea>
			</div>
			<div id="writer">
				<label>WRITER</label>
				<input type="text" name="writer" value="${boardVO.writer}" />
			</div>
			<div id="submit">	
				<input type="submit" value="수정 완료"/>
				<a href="listPage">LIST</a>
			</div>
		</form>
	</div>
</body>
</html>




