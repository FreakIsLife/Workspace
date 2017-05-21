package com.zhku.jsj.base.servlet;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.*;
import javax.servlet.http.*;

/**
 * BaseServlet用来作为其它Servlet的父类
 * 
 * 一个类多个请求处理方法，每个请求处理方法的原型与service相同！ 原型 = 返回值类型 + 方法名称 + 参数列表
 */

public class BaseServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");// 处理响应编码
		/**
		 * 1. 获取method参数，它是用户想调用的方法 2. 把方法名称变成Method类的实例对象 3. 通过invoke()来调用这个方法
		 */
		String methodName = request.getParameter("method");
		Method method = null;
		/**
		 * 2. 通过方法名称获取Method对象
		 */
		try {
			method = this.getClass().getMethod(methodName,
					HttpServletRequest.class, HttpServletResponse.class);
		} catch (Exception e) {
			throw new RuntimeException("您要调用的方法：" + methodName + "它不存在！", e);
		}

		/**
		 * 3. 通过method对象来调用它
		 */
		try {
			String result = (String) method.invoke(this, request, response);
			// 如果请求处理方法返回不为空
			if (result != null && !result.trim().isEmpty()) {
				response.getWriter().print(result);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
