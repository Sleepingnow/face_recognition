package com.sql;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.servlet.LoginTeacher;

public class AddToCourseClass {
	static Connection con;
	static PreparedStatement ps;
	static ResultSet res;
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection
						("jdbc:sqlserver://127.0.0.1:1580;DatabaseName = Face_Recognition","sa","yiyanping123");
		}catch(Exception e){
			e.printStackTrace();
		}
		return con;
	}
	public static void add(String Sid) {
		AddToCourseClass c = new AddToCourseClass();
		try {
			con = c.getConnection();
			ps = con.prepareStatement("select Sname from Student where Sid = ?");
			ps.setString(1, Sid);
			res = ps.executeQuery();
			res.next();
			String Sname = res.getString("Sname");
			
			Date date1 = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			String date = formatter.format(date1); 
			ps = con.prepareStatement("insert into CourseClass(Cname,Sid,Sname,date,Attendence) values(?,?,?,?,?)");
			ps.setString(1, LoginTeacher.course1);
			ps.setString(2, Sid);
			ps.setString(3, Sname);
			ps.setString(4, date);
			ps.setString(5, "1");
			ps.execute();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(res != null) {
				try {
					res.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
}