<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register.jsp</title>
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
		<h1>REGISTER BOARD</h1>
		<form method="POST">
			<div id="title">
				<label>TITLE</label>
				<input type="text" name="title" />
			</div>
			<div>
				<label>CONTENT</label>
				<textarea name="content" rows=3></textarea>
			</div>
			<div id="writer">
				<label>WRITER</label>
				<input type="text" name="writer" />
			</div>
			<div id="submit">
				<input type="submit" value="글작성 완료"/>
			</div>
		</form>
	</div>
</body>
</html>












