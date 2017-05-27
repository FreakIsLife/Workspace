package com.zhku.jsj.cart.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.cart.domain.Cart;
import com.zhku.jsj.cart.service.CartService;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.common.CommonUtil;

/**
 * 购物车相关servlet
 * 
 * @author Administrator
 *
 */
@WebServlet("/cartServlet")
@MultipartConfig
public class CartServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;
	private CartService cs = new CartService();

	/**
	 * 提交购物车生成订单并跳转页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String commitCart(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter("url");
		JSONArray item = JSONArray.fromObject(request.getParameter("item"));
		request.setAttribute("item", item);
		request.setAttribute("total", request.getParameter("total"));
		request.setAttribute("itemId", request.getParameter("itemId"));
		request.getRequestDispatcher(url).forward(request, response);
		return null;
	}

	/**
	 * 添加到购物车
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String buyId = request.getParameter("productId");
		int buyNum = Integer.parseInt(request.getParameter("number"));
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		String msg = cs.addCartProduct(buyId, buyNum, loginUser.getUserId());
		return msg;
	}

	/**
	 * 删除购物车商品
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String delete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String delData = request.getParameter("delData");
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		cs.deleteCartProduct(delData,loginUser.getUserId());
		return null;
	}

	/**
	 * 购物车里改变商品的数量
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String changeNum(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String productId = request.getParameter("productId");
		int num = Integer.parseInt(request.getParameter("changeNum"));
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		String msg = cs.changeNum(productId, num, loginUser.getUserId());
		return msg;
	}

	/**
	 * 获取购物车 购物车Id对应当前用户Id
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getCart(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Page pageBean = CommonUtil
				.toBean(request.getParameterMap(), Page.class);
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		List<Cart> cartList = cs.findCartById(pageBean, loginUser.getUserId());
		String cartListJson = cs.getCartListJson(cartList);
		// 需要返回的数据有总记录数和行数据
		String json = "{\"total\":" + pageBean.getTotalRow() + ",\"rows\":"
				+ cartListJson + "}";
		return json;
	}
}
