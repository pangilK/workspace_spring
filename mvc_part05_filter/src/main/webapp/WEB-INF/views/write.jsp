<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write.jsp</title>
<style>
	form{
		border : solid 1px black;
		border-radius : 5px;
		width : 250px;
		heigth : 200px;
		font-size : 15px;
		text-shadow: -1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black;
		text-align : center;
		color : white;
	}
	input{
		margin-left : 5px;
	}
</style>
</head>
<body>
	<div>
		<form action="write" method="POST">
			ID : <input type="text"  name="id"/> <br/>
			이름 :<input type="text" name="name" /> <br/>
			PW : <input type="password" name="pw"/> <br/>
			<button>WRITE</button>
		</form>
	</div>
</body>
</html>