package com.zhku.jsj.order.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.order.domain.Order;
import com.zhku.jsj.order.service.OrderService;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

/**
 * 关于订单的Servlet
 * 
 * @author Administrator
 *
 */
@WebServlet("/orderServlet")
@MultipartConfig
public class OrderServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private OrderService os = new OrderService();

	/**
	 * 生成订单
	 * 
	 * @1. 获取购物车商品的Id及数量的字符串
	 * @2. 生成当前用户的订单
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String address = request.getParameter("orderAddress");
		Order bean = new Order();
		// 判断是否是输入的地址还是选择默认的地址
		if (!"diy".equals(address)) {
			bean.setOrderAddress(address);
		} else {
			// 输入地址，将地址拼接
			String str = "";
			str += (request.getParameter("province") + " ");
			str += (request.getParameter("city") + " ");
			str += (request.getParameter("district") + " ");
			str += request.getParameter("detail");
			bean.setOrderAddress(str);
		}
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		// 下单人和订单状态相同，先设置，下单时间由数据库设置
		bean.setOrderUser(loginUser.getUserId());
		bean.setOrderStatus(1);
		// 查询所下的商品属于几个店铺
		JSONArray itemJson = JSONArray.fromObject(request
				.getParameter("itemId"));
		Map<String, Map<String, Object>> findInCart = os.findInCart(itemJson,
				loginUser.getUserId());
		List<Shop> shopList = os.findAndMix(itemJson);
		os.addOrder(shopList, bean, findInCart);
		os.delCartItem(itemJson, loginUser.getUserId());
		request.getRequestDispatcher("/user/commitSuccess.jsp").forward(
				request, response);
		return null;
	}
}
