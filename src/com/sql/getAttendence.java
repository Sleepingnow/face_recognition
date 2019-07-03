package com.sql;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.servlet.LoginTeacher;

import net.sf.json.JSONArray;

public class getAttendence {
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
	public static List<Message> Add() throws Exception{
		getAttendence c = new getAttendence();
			con = c.getConnection();
			ps = con.prepareStatement("select * from Attendence where Attendence = 1 and Cid = ?");
			ps.setString(1, LoginTeacher.course1);
			res = ps.executeQuery();
			List<Message> msgList = new ArrayList<Message>();
			while (res.next()) {			
				String Cname = res.getString("Cname"); 	
				String Sid = res.getString("Sid"); 	
				String Sname = res.getString("Sname"); 			
				String date = res.getString("date");		
				int attendence = res.getInt("Attendence"); 	
				Message message = new Message();
				message.setCname(Cname);
				message.setSid(Sid);
				message.setSname(Sname);
				message.setDate(date);
				message.setAttendence(attendence);
				msgList.add(message);//添加进集合		
				}
			return msgList;
	}
	
	/*public static void main(String[] args) throws Exception {				
		//遍历集合		
		List<Message> msg = Add();	
		for (Message message : msg) {			
			System.out.println(message);		
			}		
		//listBook3();	
		JSONArray data = JSONArray.fromObject(msg);
		System.out.println(data);
		}*/
}