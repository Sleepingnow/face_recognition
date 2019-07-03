<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人脸识别考勤系统</title>
<style type="text/css">
h1{
	font-family: verdana,arial,sans-serif;
    font-size:20px;
    color:#333333;
    border-width: 1px;
    border-color: #a9c6c9;
    border-collapse: collapse;
}
table.tab {
    font-family: verdana,arial,sans-serif;
    font-size:15px;
    color:#333333;
    border-width: 1px;
    border-color: #a9c6c9;
    border-collapse: collapse;
}
table.tab th {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
table.tab td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
.oddrowcolor{
    background-color:#d4e3e5;
}
.evenrowcolor{
    background-color:#c3dde0;
}
</style>
</head>
<body>
<h1>当前签到情况</h1>
	<table class = "tab" id = "tab1" border = "1">
		<tr>
			<th>课程名</th>
			<th>姓名</th>
			<th>打卡时间</th>
		</tr>
	</table>

<h1>当前未签到学生</h1>
	<table class = "tab" id = "tab2" border = "1">
		<tr>
			<th>学号</th>
			<th>姓名</th>
		</tr>
	</table>
	
</body>
<script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	requestData1();
	requestData2();
	
	window.onload=function(){
	    altRows('alternatecolor');
	}
});
function altRows(id){
    if(document.getElementsByTagName){ 
         
        var table = document.getElementById(id); 
        var rows = table.getElementsByTagName("tr");
          
        for(i = 0; i < rows.length; i++){         
            if(i % 2 == 0){
                rows[i].className = "evenrowcolor";
            }else{
                rows[i].className = "oddrowcolor";
            }     
        }
    }
}
 
function requestData1(){
	$.ajax({
				url: "/Face_Recognition/servlet/MsgAttend",
				type: "post",
				dataType: "json",
				success: function(data){
					/*这个方法里是ajax发送请求成功之后执行的代码*/
				var str = "";//定义用于拼接的字符串
		        for (var i = 0; i < data.length; i++) {
		             //拼接表格的行和列
		             str = "<tr><td>" + data[i].sid + "</td><td>" + data[i].sname + "</td><td>" + data[i].date + "</td></tr>";
		             //追加到table中
		             $("#tab1").append(str);         }
					
			},
			error: function(msg){
					alert("ajax连接异常："+msg);
			}
			});
	};
function requestData2(){
	$.ajax({
				url: "/Face_Recognition/servlet/MsgAttend2",
				type: "post",
				dataType: "json",
				success: function(data){
					/*这个方法里是ajax发送请求成功之后执行的代码*/
				var str = "";//定义用于拼接的字符串
			    for (var i = 0; i < data.length; i++) {
			             //拼接表格的行和列
			        str = "<tr><td>" + data[i].sid + "</td><td>" + data[i].sname + "</td></tr>";
			             //追加到table中
			        $("#tab2").append(str);         }
						
				},
				error: function(msg){
					alert("ajax连接异常："+msg);
				}
				});
		};

        </script>
</html>