<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read.jsp</title>
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
		<h3>READ BAORD</h3>
		<!-- model boardVO -->
		<div id="title">
			<label>TITLE</label>
			<input type="text" name="title" value="${boardVO.title}" readonly/>
		</div>
		<div>
			<label>CONTENT</label>
			<textarea name="content" readonly rows=3>${boardVO.content}</textarea>
		</div>
		<div id="writer">
			<label>WRITER</label>
			<input type="text" name="writer" value="${boardVO.writer}" readonly/>
		</div>
		<div id="submit">
			<a href="modify?bno=${boardVO.bno}">MODIFY</a> |
			<a href="remove?bno=${boardVO.bno}">DELETE</a> |
			<a href="listPage">LIST</a>
		</div>
	</div>
	<script>
		var result = '${result}';
		if(result != null && result != ''){
			alert(result);
		}
	</script>
</body>
</html>




