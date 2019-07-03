<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SQLTest</title>
<style>
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
<%
	String Sname=new String(request.getParameter("Sname").getBytes("iso-8859-1"), "utf-8");
	Connection con;
	PreparedStatement ps;
	ResultSet res;
	try{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//获取数据库连对象
	}catch(Exception e){
		out.println("忘记把mySQL数据库的jdbc数据库驱动程序复制到jdk的扩展目录中 ");
	}
	
	try{
		String url="jdbc:sqlserver://127.0.0.1:1580;DatabaseName = Face_Recognition"; //数据库连接字
		String name="sa";
		String pass="yiyanping123";
		con = DriverManager.getConnection(url,name,pass);//加载并注册驱动程序
		ps = con.prepareStatement("select * from Student where Sname = ?");
		ps.setString(1, Sname);
		res = ps.executeQuery();
		if(!res.next())
			out.println("不存在姓名为" + Sname + "的学生，查找失败！");
		else{	
			out.print("<h2>查到学生情况如下</h2>");
			ps = con.prepareStatement("select * from Student where Sname = ?");
			ps.setString(1, Sname);	
			res = ps.executeQuery();
			out.print("<table class = tab id = tab1 border=2>");
			out.print("<tr>");
			out.print("<th width = 100>"+"学号");
			out.print("<th width = 100>"+"姓名");
			out.print("<th width = 100>"+"性别");
			out.print("<th width = 100>"+"专业");
			out.print("</tr>");
			while(res.next()){
				out.print("<tr>");
					out.print("<td>"+res.getString(1)+"</td>");
					out.print("<td>"+res.getString(2)+"</td>");
					out.print("<td>"+res.getString(3)+"</td>");
					out.print("<td>"+res.getString(4)+"</td>");
				out.print("</tr>");
			}
			out.print("</table>"); 
		}
		ps = con.prepareStatement("select * from Student where Sname = ?");
		ps.setString(1, Sname);
		res = ps.executeQuery();
		if(!res.next())
			con.close();
		else{	
			out.print("<h2>所查学生选修情况</h2>");
			ps = con.prepareStatement("select * from CourseClass where Sname = ?");
			ps.setString(1, Sname);	
			res = ps.executeQuery();
			out.print("<table class = tab id = tab2 border=2>");
			out.print("<tr>");
			out.print("<th width = 100>"+"课程号");
			out.print("<th width = 100>"+"课程名");
			out.print("<th width = 100>"+"教师号");
			out.print("<th width = 100>"+"教师名");
			out.print("<th width = 100>"+"学号");
			out.print("<th width = 100>"+"学生名");
			out.print("<th width = 100>"+"已签到次数");
			out.print("</tr>");
			while(res.next()){
				out.print("<tr>");
					out.print("<td>"+res.getString(1)+"</td>");
					out.print("<td>"+res.getString(2)+"</td>");
					out.print("<td>"+res.getString(3)+"</td>");
					out.print("<td>"+res.getString(4)+"</td>");
					out.print("<td>"+res.getString(5)+"</td>");
					out.print("<td>"+res.getString(6)+"</td>");
					out.print("<td>"+res.getString(7)+"</td>");
				out.print("</tr>");
			}
			out.print("</table>"); 
			con.close();
		}
	}catch(SQLException e){
		out.print(e);
	}
%>
</body>
</html>