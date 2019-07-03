package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sql.GetElse;
import com.sql.Message;
import com.sql.getAttendence;
import com.util.AuthService;

import net.sf.json.JSONArray;

public class MsgAttend2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
			try {
				List<Message> list = GetElse.Add();
				JSONArray data = JSONArray.fromObject(list);
				//��������������
				/*���ñ��룬��ֹ������������*/
				resp.setCharacterEncoding("utf-8");
				/*�õ������*/
				PrintWriter respWritter = resp.getWriter();
				System.out.println(data.toString());
				/*��JSON��ʽ�Ķ���toString()����*/
				respWritter.print(data);
				respWritter.flush();	
				respWritter.close();
				
			} catch (Exception e) {
				// TODO �Զ����ɵ� catch ��
				e.printStackTrace();
			}
	}

}