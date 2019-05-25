package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sql.AddToSql2;
import com.util.AuthService;


public class RegisterTeacher extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String base64 = req.getParameter("img");
		String user = req.getParameter("user");
		String tid = req.getParameter("tid");
		String sex = req.getParameter("sex");
		String course = req.getParameter("course");
		AuthService.faceAdd(base64,user);
		AddToSql2.add(tid,user,sex,course);
	}
	
}
