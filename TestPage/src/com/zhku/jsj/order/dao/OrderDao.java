package com.zhku.jsj.order.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.zhku.jsj.order.domain.Order;
import com.zhku.jsj.order.domain.OrderItem;
import com.zhku.jsj.pager.Page;

public interface OrderDao {

	/**
	 * 添加订单
	 * 
	 * @param orderList
	 * @throws SQLException
	 */
	void addOrder(List<Order> orderList) throws SQLException;

	/**
	 * 对要查询的订单条数进行统计，方便返回JSON数据时要用的total
	 * 
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	int countByParams(Map<String, Object> params) throws SQLException;

	/**
	 * 通过参数返回要查询的订单List
	 * @param pageBean
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	List<Order> findByParams(Page pageBean, Map<String, Object> params)
			throws SQLException;

	/**
	 * 通过订单Id返回相应的订单项
	 * @param orderId
	 * @return
	 * @throws SQLException
	 */
	List<OrderItem> findItemById(String orderId) throws SQLException;

	/**
	 * 根据订单号改变订单状态
	 * @param orderId
	 * @param status
	 * @throws SQLException
	 */
	void updateStatusById(String orderId, int status) throws SQLException;

	/**
	 * 更新状态时 取出交易成功的订单项的商品Id和数量
	 * @param orderId
	 * @throws SQLException
	 */
	Map<String, Map<String, Object>> findProductAndNumById(String orderId) throws SQLException;

}
