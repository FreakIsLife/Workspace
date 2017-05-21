package com.zhku.jsj.user.servlet;

import java.io.IOException;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.user.service.UserService;
import com.zhku.jsj.utils.common.CommonUtil;
import com.zhku.jsj.utils.upload.FileItemUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

/**
 * 关于用户表的servlet
 * 
 * @author Administrator
 *
 */
@WebServlet("/userServlet")
@MultipartConfig
public class UserServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;
	private UserService us = new UserService();

	/**
	 * 开启用户的店铺
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String setShop(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		if (loginUser.getUserIsShop() != 0) {
			return "您已经开通店铺了！";
		}
		Shop bean = CommonUtil.toBean(request.getParameterMap(), Shop.class);
		bean.setShopId(loginUser.getUserId());
		Shop saveShop = null;
		if ((saveShop = us.setShop(bean)) == null) {
			return "发生未知错误，开通店铺失败";
		} else {
			loginUser.setUserIsShop(1);
			loginUser.setUserShop(saveShop);
			request.getSession().setAttribute("loginUser", loginUser);
		}
		return null;

	}

	/**
	 * 保存用户个人信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String saveInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		User bean = CommonUtil.toBean(request.getParameterMap(), User.class);
		String filePath = FileItemUtil.doFileUpload(request, "userImg");
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String userImg = loginUser.getUserImg();
		if(userImg==null) {
			//用户没有头像，用上传头像更新
			bean.setUserImg(filePath);
		} else if("".equals(filePath)) {
			// 用户有头像，但没有上传头像
			bean.setUserImg(userImg);
		} else if(!userImg.equals(filePath)) {
			//用户有旧头像和上传头像而且两个路径不一样
			bean.setUserImg(filePath);
			FileItemUtil.deleteOldImg(request, userImg);
		} else{
			//用户没有更改头像
			bean.setUserImg(userImg);
		}
		bean.setUserPassword(loginUser.getUserPassword());
		us.saveInfo(bean);
		bean.setUserIsShop(loginUser.getUserIsShop());
		session.setAttribute("loginUser", bean);
		return null;
	}

	/**
	 * 登录Servlet 1.调用service进行登录验证 2.如果返回值为null则登录失败，否则登录成功
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User bean = CommonUtil.toBean(request.getParameterMap(), User.class);
		User loginUser = us.login(bean);
		if (loginUser == null) {
			return "用户名或密码错误！";
		} else {
			request.getSession().setAttribute("loginUser", loginUser);
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
		request.getSession().removeAttribute("loginUser");
		return null;
	}

	/**
	 * 注册servlet 1.在注册前已经用ajax异步校验过用户名 2.将request表单数据封装成bean 3.调用service进行注册
	 * 4.将注册用户当做登录用户存放到session然后浏览器刷新页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String regist(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		User bean = CommonUtil.toBean(request.getParameterMap(), User.class);
		if (bean.getUserNickname() == null || "".equals(bean.getUserNickname())) {
			bean.setUserNickname(bean.getUserId());
		}
		us.regist(bean);
		request.getSession().setAttribute("loginUser", bean);
		return null;

	}

	/**
	 * 注册时，校验用户名是否存在
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String validate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		boolean result = us.validateId(userId);
		JSONObject jso = new JSONObject();
		jso.put("valid", result);
		response.getWriter().print(jso);
		return null;
	}
}
