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
	String Cid=request.getParameter("Cid");
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
		ps = con.prepareStatement("select Cname from Course where Cid = ?");
		ps.setString(1, Cid);
		res = ps.executeQuery();
		if(!res.next())
			out.println("不存在" + Cid + "号课程，删除失败！");
		else{	
			ps = con.prepareStatement("delete from Course where Cid = ?");
			ps.setString(1, Cid);
			ps.execute();
			con.close();
			out.println(Cid + "号课程已成功删除");
		}
	}catch(SQLException e){
		out.print(e);
	}
%>
</body>
</html>