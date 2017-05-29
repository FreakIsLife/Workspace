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

public class PjaxPageFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		boolean is_Pjax = Boolean.parseBoolean(req.getHeader("X-PJAX"));
		if (is_Pjax) {
			chain.doFilter(req, res);
		} else {
			String URI = req.getServletPath();
			String Catalog = URI.substring(1, URI.lastIndexOf("/"));
			String realURI = URI.substring(0, URI.lastIndexOf("/") + 1);
			String choose = URI.substring(URI.lastIndexOf("/") + 1,
					URI.lastIndexOf("."));
			if ("user".equals(Catalog)) {
				realURI += "userCenter.jsp";
			} else if ("page".equals(Catalog)) {
				realURI += "home.jsp";
			} else if ("shop".equals(Catalog)) {
				realURI = "/user/userCenter.jsp";
			}
			if (!"userCenter".equals(choose) && !"home".equals(choose)) {
				req.setAttribute("choose", choose);
			}
			req.getRequestDispatcher(realURI).forward(req, res);
		}
	}

	@Override
	public void destroy() {
	}

}
