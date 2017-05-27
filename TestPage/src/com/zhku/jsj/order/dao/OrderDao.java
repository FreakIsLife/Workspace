package com.zhku.jsj.order.dao;

import java.sql.SQLException;
import java.util.List;

import com.zhku.jsj.order.domain.Order;

public interface OrderDao {

	/**
	 * 添加订单
	 * @param orderList
	 * @throws SQLException
	 */
	void addOrder(List<Order> orderList) throws SQLException;

}
