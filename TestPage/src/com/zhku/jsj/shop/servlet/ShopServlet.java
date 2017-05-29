package com.zhku.jsj.shop.servlet;

import java.io.IOException;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.shop.service.ShopService;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.common.CommonUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 店铺相关servlet
 * @author Administrator
 *
 */
@WebServlet("/shopServlet")
@MultipartConfig
public class ShopServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private ShopService ss = new ShopService();

	/**
	 * 获取店铺的信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getShopInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		Shop shop = ss.getShopInfo(loginUser.getUserId());
		request.setAttribute("shop", shop);
		request.getRequestDispatcher("/shop/showShopInfo.jsp").forward(request,
				response);
		return null;
	}

	/**
	 * 保存店铺修改的信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String saveInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Shop bean = CommonUtil.toBean(request.getParameterMap(), Shop.class);
		ss.saveInfo(bean);
		return null;
	}

}
