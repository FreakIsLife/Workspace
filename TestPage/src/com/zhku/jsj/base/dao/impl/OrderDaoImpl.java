package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;

import com.zhku.jsj.order.dao.OrderDao;
import com.zhku.jsj.order.domain.Order;
import com.zhku.jsj.order.domain.OrderItem;
import com.zhku.jsj.utils.jdbc.TxQueryRunner;

public class OrderDaoImpl implements OrderDao {

	private QueryRunner qr = new TxQueryRunner();

	@Override
	public void addOrder(List<Order> orderList) throws SQLException {
		String sql = "insert into order_info value(?,?,?,?,?,null,?)";
		Object[][] beanOrder = new Object[orderList.size()][6];
		List<Object[][]> beanItem = new ArrayList<Object[][]>();
		int index = 0;
		for (Order order : orderList) {
			beanOrder[index][0] = order.getOrderId();
			beanOrder[index][1] = order.getOrderStatus();
			beanOrder[index][2] = order.getOrderTotal();
			beanOrder[index][3] = order.getOrderAddress();
			beanOrder[index][4] = order.getOrderUser();
			beanOrder[index][5] = order.getOrderShop();
			index++;
			Object[][] subItem = new Object[order.getOrderItem().size()][8];
			int subIndex = 0;
			for (OrderItem item : order.getOrderItem()) {
				subItem[subIndex][0] = item.getItemId();
				subItem[subIndex][1] = item.getItemNum();
				subItem[subIndex][2] = item.getItemProduct();
				subItem[subIndex][3] = item.getItemImg();
				subItem[subIndex][4] = item.getItemName();
				subItem[subIndex][5] = item.getItemPrice();
				subItem[subIndex][6] = item.getItemTotal();
				subItem[subIndex][7] = item.getItemOrder();
				subIndex++;
			}
			beanItem.add(subItem);
		}
		qr.batch(sql, beanOrder);
		sql = "insert into order_item value(?,?,?,?,?,?,?,?)";
		for (Object[][] beanObject : beanItem) {
			qr.batch(sql, beanObject);
		}
	}
}
