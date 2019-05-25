package com.sql;

import java.sql.*;

public class AddToSql2 {
	static Connection con;
	static PreparedStatement ps;
	static ResultSet res;
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection
						("jdbc:sqlserver://127.0.0.1:1433;DatabaseName = Face_Recogniton","sa","yiyanping123");
		}catch(Exception e){
			e.printStackTrace();
		}
		return con;
	}
	public static void add(String Tid, String Tname, String sex, String className) {
		AddToSql2 c = new AddToSql2();
		try {
			con = c.getConnection();
			ps = con.prepareStatement("insert into Teacher(Tid,Tname,sex,class) values(?,?,?,?)");
			ps.setString(1, Tid);
			ps.setString(2, Tname);
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