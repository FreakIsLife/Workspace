package com.zhku.jsj.user.servlet;

import java.io.IOException;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.user.service.UserService;
import com.zhku.jsj.utils.common.CommonUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/user")
public class UserServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;
	private UserService us = new UserService();

	@SuppressWarnings("unused")
	public String login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User bean = CommonUtil.toBean(request.getParameterMap(), User.class);
		User loginUser = us.login(bean);		
		System.out.println(loginUser.getUserNickname());
		if (loginUser == null) {
			request.setAttribute("msg", "用户名或密码错误！");
			return "f:/login.jsp";
		} else {
			request.getSession().setAttribute("loginUser", loginUser);
			return "f:/home.html";
		}

	}
}
