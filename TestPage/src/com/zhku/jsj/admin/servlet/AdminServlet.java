package com.zhku.jsj.admin.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhku.jsj.admin.domain.Admin;
import com.zhku.jsj.admin.service.AdminService;
import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.pager.PageBean;
import com.zhku.jsj.pager.PageShop;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.user.service.UserService;
import com.zhku.jsj.utils.common.CommonUtil;

@WebServlet("/adminServlet")
@MultipartConfig
public class AdminServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	private AdminService us = new AdminService();
	private UserService userservice = new UserService();

	/*
	 * 用户登录
	 */
	public String login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		Admin bean = CommonUtil.toBean(request.getParameterMap(), Admin.class);
		Admin loginAdmin = us.login(bean);
		if (loginAdmin == null) {
			request.setAttribute("msg", "用户名或密码错误！");
			request.getRequestDispatcher("adminjsps/login.jsp").forward(
					request, response);
			return null;
		} else {
			request.getSession().setAttribute("loginAdmin", loginAdmin);
			response.sendRedirect(request.getContextPath()
					+ "/adminjsps/home.jsp");
			return null;
		}
	}

	/**
	 * 注销用户，因为只移除session，则不需要调用业务层逻辑
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String logout(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.getSession().removeAttribute("loginAdmin");
		request.getRequestDispatcher("adminjsps/login.jsp").forward(request,
				response);
		return null;
	}

	/*
	 * 加载用户信息
	 */
	public String load(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<User> user = userservice.load();
		request.setAttribute("user", user);
		request.setAttribute("pageNum", "1");
		PageQueryDate(request, response);
		return null;
	}

	/**
	 * 删除用户信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String deleteUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		userservice.deleteUser(userId);
		request.getRequestDispatcher("adminjsps/home.jsp").forward(request,
				response);
		return null;
	}

	/**
	 * 添加用户信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String addUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 1. 封装表单数据到User对象
		 */
		User bean = CommonUtil.toBean(request.getParameterMap(), User.class);
		/*
		 * 2. 校验之, 如果校验失败，保存错误信息
		 */
		Map<String, String> errors = validateaddUser(bean, request.getSession());
		if (errors.size() > 0) {
			request.setAttribute("form", bean);
			request.setAttribute("msg", errors);
		}

		/*
		 * 3. 使用service完成业务
		 */
		us.addUser(bean);
		/*
		 * request.getRequestDispatcher("adminjsps/home.jsp").forward(request,
		 * response);
		 */
		return null;
	}

	/*
	 * 注册校验 对表单的字段进行逐个校验，如果有错误，使用当前字段名称为key，错误信息为value，保存到map中 返回map
	 */
	private Map<String, String> validateaddUser(User formUser,
			HttpSession session) {
		Map<String, String> errors = new HashMap<String, String>();
		/*
		 * 1. 校验登录名
		 */
		String userId = formUser.getUserId();
		if (userId == null || userId.trim().isEmpty()) {
			errors.put("userId", "用户名不能为空！");
		} else if (userId.length() < 3 || userId.length() > 20) {
			errors.put("userId", "用户名长度必须在3~20之间！");
		} else if (!us.ValiaddUserId(userId)) {
			errors.put("userId", "用户名已被注册！");
		}
		return errors;
	}

	/**
	 * 对用户信息进行分页查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String PageQueryDate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pageNum = (String) request.getAttribute("pageNum");
		if (pageNum == null || "".equals(pageNum)) {
			pageNum = request.getParameter("pageNum");
		}
		PageBean pagebean = us.PageQuery(pageNum);
		request.setAttribute("pagebean", pagebean);
		request.getRequestDispatcher("adminjsps/manageuser/userinfo.jsp")
				.forward(request, response);
		return null;
	}

	/**
	 * 修改用户信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String EditUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		User bean = CommonUtil.toBean(request.getParameterMap(), User.class);
		us.EditUser(bean);
		return null;
	}

	/**
	 * 添加商品信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String AddShop(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Shop shop = CommonUtil.toBean(request.getParameterMap(), Shop.class);
		if ((us.AddShop(shop)) == null) {
			return "发生未知错误，开通店铺失败";
		} else {
			request.getRequestDispatcher("adminjsps/home.jsp").forward(request,
					response);
		}
		return null;
	}

	/**
	 * 加载商店信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String loadShop(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		List<Shop> shop = us.loadShop();
		request.setAttribute("shop", shop);
		request.setAttribute("pageNum", "1");
		PageQueryShop(request, response);
		return null;
	}

	/**
	 * 修改商店信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String EditShop(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Shop shop = CommonUtil.toBean(request.getParameterMap(), Shop.class);
		us.EditShop(shop);
		request.getRequestDispatcher("adminjsps/home.jsp").forward(request,
				response);
		return null;
	}

	/**
	 * 删除商店信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String deleteShop(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String shopId = request.getParameter("shopId");
		us.deleteShop(shopId);
		request.getRequestDispatcher("adminjsps/home.jsp").forward(request,
				response);
		return null;
	}

	/**
	 * 商店信息分页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String PageQueryShop(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pageNum = (String) request.getAttribute("pageNum");
		if (pageNum == null || "".equals(pageNum)) {
			pageNum = request.getParameter("pageNum");
		}
		PageShop pageshop = us.PageQueryShop(pageNum);
		request.setAttribute("pageshop", pageshop);
		request.getRequestDispatcher("adminjsps/manageshop/shopinfo.jsp")
				.forward(request, response);
		return null;
	}

	public String searchId(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String Id = request.getParameter("Id");
		User userinfo = us.SearchUserInfo(Id);
		if (userinfo == null) {
			request.setAttribute("usermsg", "你查找的用户不存在！");
		} else {
			request.setAttribute("userinfo", userinfo);
		}
		Shop shopinfo = us.SearchShopInfo(Id);
		if (shopinfo == null) {
			request.setAttribute("shopmsg", "对不起，你还没有开店！");
		} else {
			request.setAttribute("shopinfo", shopinfo);
		}
		request.getRequestDispatcher("adminjsps/searchinfo/searchinfo.jsp")
				.forward(request, response);
		return null;
	}
}
