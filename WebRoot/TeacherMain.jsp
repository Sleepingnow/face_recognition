<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人脸识别考勤系统</title>
<style type="text/css">
body {
	background: url("./images/bg1.jpg") no-repeat;
	background-size: 100% auto;
	background-attachment: fixed;
}

h1 {
	text-align: center;
}

.btn_recognition {
	display: block;
	width: 160px;
	height: 40px;
	margin: 20px auto;
	background: teal;
	text-align: center;
	line-height: 40px;
	font-size: 16px;
	color: white;
	text-decoration: none;
	border-radius: 10px;
}

.btn_recognition:hover {
	background: orange;
}
.a_register{
	display: block;
	width: 160px;
	height: 40px;
	margin: 20px auto;
	background: teal;
	text-align: center;
	line-height: 40px;
	font-size: 16px;
	color: white;
	text-decoration: none;
	border-radius: 10px;
}
.a_register:hover {
	background: orange;
}
</style>

</head>
<body>
	
	
	<a href="/Face_Recognition/StudentLogin.jsp" class="a_register">开启人脸识别</a>
	<a href="/Face_Recognition/AttendMsg.jsp" class="btn_recognition">查看签到情况</a>
</body>
<script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
          
        </script>
</html>