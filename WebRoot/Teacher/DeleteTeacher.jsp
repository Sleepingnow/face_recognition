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
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	String Tid=request.getParameter("Tid");
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
		ps = con.prepareStatement("select Tname from Teacher where Tid = ?");
		ps.setString(1, Tid);
		res = ps.executeQuery();
		if(!res.next())
			out.println("不存在" + Tid + "号老师，删除失败！");
		else{	
			ps = con.prepareStatement("delete from Teacher where Tid = ?");
			ps.setString(1, Tid);
			ps.execute();
			con.close();
			out.println(Tid + "号学生已成功删除");
		}
	}catch(SQLException e){
		out.print(e);
	}
%>
</body>
</html>