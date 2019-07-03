package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sql.*;
import com.util.AuthService;
import com.util.PinyinUtils;

public class RegisterFace extends HttpServlet {

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
		String sid = req.getParameter("sid");
		String sex = req.getParameter("sex");
		String course = req.getParameter("course");
		AuthService.faceAdd(base64,sid);
		AddToSql1.add(sid,user,sex,course);
	}
	
}
