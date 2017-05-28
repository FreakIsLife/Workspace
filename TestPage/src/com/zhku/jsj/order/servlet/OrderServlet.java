package com.zhku.jsj.order.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.order.domain.Order;
import com.zhku.jsj.order.domain.OrderItem;
import com.zhku.jsj.order.service.OrderService;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.common.CommonUtil;

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
	 * 更新订单状态
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String updateStatus(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String orderId = request.getParameter("orderId");
		String orderStatus = request.getParameter("status");
		os.updateStatus(orderId,orderStatus);
		return null;
	}
	/**
	 * 获取订单项
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getOrderItem(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String orderId = request.getParameter("orderId");
		List<OrderItem> itemList = os.findOrderItem(orderId);
		String itemListJson = os.getItemListJson(itemList);
		return itemListJson;
	}

	/**
	 * 获取我的订单
	 * 
	 * @1. 获取查询的条件，包括分页的大小、偏移量、过滤的订单状态
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getMyOrder(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Page pageBean = CommonUtil
				.toBean(request.getParameterMap(), Page.class);
		// 获取查询的订单Id
		String orderId = request.getParameter("orderId");
		String status = request.getParameter("statusSelect");
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		List<Order> orderList = os.findMyOrder(pageBean, orderId, status,
				loginUser.getUserId());
		String orderListJson = os.getOrderListJson(orderList);
		// 需要返回的数据有总记录数和行数据
		String json = "{\"total\":" + pageBean.getTotalRow() + ",\"rows\":"
				+ orderListJson + "}";
		return json;
	}

	/**
	 * 获取店铺的订单
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getShopOrder(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Page pageBean = CommonUtil
				.toBean(request.getParameterMap(), Page.class);
		// 获取查询的订单Id
		String orderId = request.getParameter("orderId");
		String status = request.getParameter("statusSelect");
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		List<Order> orderList = os.findShopOrder(pageBean, orderId, status,
				loginUser.getUserId());
		String orderListJson = os.getOrderListJson(orderList);
		// 需要返回的数据有总记录数和行数据
		String json = "{\"total\":" + pageBean.getTotalRow() + ",\"rows\":"
				+ orderListJson + "}";
		return json;
	}
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
