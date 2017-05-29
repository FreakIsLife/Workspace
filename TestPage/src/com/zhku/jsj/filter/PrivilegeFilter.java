package com.zhku.jsj.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhku.jsj.user.domain.User;

public class PrivilegeFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		Object bean = req.getSession().getAttribute("loginUser");
		String URI = req.getServletPath();
		String Catalog = URI.substring(1, URI.lastIndexOf("/"));
		if (bean == null) {
			req.setAttribute("msg", "你没有权限访问该页面！");
			req.getRequestDispatcher("/page/denyPage.jsp").forward(req, res);
		} else if ("shop".equals(Catalog) && ((User) bean).getUserIsShop() != 1) {
			req.setAttribute("msg", "你没有开店，不能打开页面！");
			req.getRequestDispatcher("/page/denyPage.jsp").forward(req, res);
		} else {
			chain.doFilter(req, res);
		}
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
