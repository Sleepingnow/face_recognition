<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Admin</title>
<Style>
body { 
	padding:50px 100px; 
	font:13px/150% Verdana, Tahoma, sans-serif; 
}   
  
/* tutorial */  
  
input, textarea {    
	 padding: 9px;   
	 border: solid 1px #E5E5E5;   
	 outline: 0;   
	 font: normal 13px/100% Verdana, Tahoma, sans-serif;   
	 width: 200px;   
	 background: -webkit-gradient(linear, left top, left 25, from(#FFFFFF), color-stop(4%, #EEEEEE), to(#FFFFFF));   
	 background: -moz-linear-gradient(top, #FFFFFF, #EEEEEE 1px, #FFFFFF 25px);   
	 box-shadow: rgba(0,0,0, 0.1) 0px 0px 8px;   
	 -moz-box-shadow: rgba(0,0,0, 0.1) 0px 0px 8px;   
	 -webkit-box-shadow: rgba(0,0,0, 0.1) 0px 0px 8px;   
 }   
  
textarea {    
	 width: 400px;   
	 max-width: 400px;   
	 height: 150px;   
	 line-height: 150%;   
 }   
  
input:hover, textarea:hover,   
input:focus, textarea:focus {    
	 border-color: #C9C9C9;    
	 -webkit-box-shadow: rgba(0, 0, 0, 0.15) 0px 0px 8px;   
 }   
  
.form label {    
	 margin-left: 10px;    
	 color: #999999;    
 }   
  
.submit input {   
	 width: auto;   
	 padding: 9px 15px;   
	 background: #617798;   
	 border: 0;   
	 font-size: 14px;   
	 color: #FFFFFF;   
	 -moz-border-radius: 5px;   
	 -webkit-border-radius: 5px;   
 }   
</Style>
</head>
<body>
	<h2>Student Management System</h2>
	<div class="show">
		<p>Search students.</p>
		<form class="show-student" action="./Student/SearchStudent.jsp" method="post">
			<input type="text" name="Sname" placeholder="学生姓名"/>
            <input type="submit" value="查询学生"/>
        </form>
	</div>
	<div class="delete">
		<p>Delete student.</p>
        <form class="delete-student" action="./Student/DeleteStudent.jsp" method="post">
            <input type="text" name="Sid" placeholder="学号"/>
            <input type="submit" value="删除"/>
        </form>
	</div>
	
	<h2>Teacher Management System</h2>
	
	<div class="show">
		<p>Search teachers.</p>
		<form class="show-teacher" action="./Teacher/SearchTeacher.jsp" method="post">
			<input type="text" name="Tname" placeholder="教师姓名"/>
            <input type="submit" value="查询教师"/>
        </form>
	</div>
	<div class="delete">
		<p>Delete teacher.</p>
        <form class="delete-teacher" action="./Teacher/DeleteTeacher.jsp" method="post">
            <input type="text" name="Tid" placeholder="教师工号"/>
            <input type="submit" value="删除"/>
        </form>
	</div>
	
	<h2>Course Management System</h2>
	<div class="add">
        <p>Add course.</p>
        <form class="add-course" action="./Course/AddToCourse.jsp" method="post">
            <input type="text" name="Cid" placeholder="课程号"/>
            <input type="text" name="Cname" placeholder="课程名"/>
            <input type="text" name="Tname" placeholder="授课教师"/>
            <input type="submit" value="添加"/>
        </form>
	</div>
	<div class="show">
        <p>Search courses.</p>
		<form class="show-course" action="./Course/SearchCourse.jsp" method="post">
			<input type="text" name="Cname" placeholder="课程名"/>
            <input type="submit" value="查询课程"/>
        </form>
	</div>
	<div class="delete">
        <p>Delete course.</p>
        <form class="delete-course" action="./Course/DeleteCourse.jsp" method="post">
            <input type="text" name="Cid" placeholder="课程号"/>
            <input type="submit" value="删除"/>
        </form>
	</div>
</body>
</html>