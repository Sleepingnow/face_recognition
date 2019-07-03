<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SQLTest</title>
</head>
<body>
<%
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
		ps = con.prepareStatement("select * from Attendence where Attendence = 1");
		res = ps.executeQuery();
		out.print("<table border=2>");
		out.print("<tr>");
		out.print("<th width = 100>"+"Sno");
		out.print("<th width = 100>"+"Sname");
		out.print("<th width = 100>"+"Snicheng");
		out.print("<th width = 100>"+"Scondition");
		out.print("<th width = 100>"+"java");
		out.print("<th width = 100>"+"os");
		out.print("<th width = 100>"+"math");
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
	}catch(SQLException e){
		out.print(e);
	}
%>
</body>
</html>