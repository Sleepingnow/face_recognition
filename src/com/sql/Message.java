package com.sql;

public class Message {
		/*public Message(String cid, String sname, String date, int attendence) {
			// TODO 自动生成的构造函数存根
			this.Cid = cid;
			this.Sname = sname;
			this.date = date;
			this.attendence = attendence;
		}*/
		String Cname;
		String Sid;
		String Sname;
		String date;
		int attendence;
		public String getCname() {
			return Cname;
		}
		public void setCname(String cid) {
			Cname = cid;
		}
		public String getSid() {
			return Sid;
		}
		public void setSid(String sid) {
			Sid = sid;
		}
		public String getSname() {
			return Sname;
		}
		public void setSname(String sname) {
			Sname = sname;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public int getAttendence() {
			return attendence;
		}
		public void setAttendence(int attendence) {
			this.attendence = attendence;
		}

}
