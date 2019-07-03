package com.sql;

import java.sql.*;

public class AddToSql1 {
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
	public static void add(String Sid, String Sname, String sex, String className) {
		AddToSql1 c = new AddToSql1();
		try {
			con = c.getConnection();
			ps = con.prepareStatement("insert into Student(Sid,Sname,sex,class) values(?,?,?,?)");
			ps.setString(1, Sid);
			ps.setString(2, Sname);
			ps.setString(3, sex);
			ps.setString(4, className);
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