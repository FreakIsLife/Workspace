package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.KeyedHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.zhku.jsj.order.dao.OrderDao;
import com.zhku.jsj.order.domain.Order;
import com.zhku.jsj.order.domain.OrderItem;
import com.zhku.jsj.pager.Page;
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

	@Override
	public int countByParams(Map<String, Object> param) throws SQLException {
		String sql = "select count(*) from order_info where 1=1";
		List<Object> paramList = new ArrayList<Object>();
		for (String key : param.keySet()) {
			if (!"".equals(param.get(key)) && param.get(key) != null) {
				if ("userId".equals(key)) {
					sql += " and orderUser=?";
				}
				if ("shopId".equals(key)) {
					sql += " and orderShop=?";
				}
				if ("orderId".equals(key)) {
					sql += " and orderId=?";
				}
				if ("status".equals(key)) {
					sql += " and orderStatus=?";
				}
				paramList.add(param.get(key));
			}
		}
		Object[] params = paramList.toArray();
		Number rs = qr.query(sql, new ScalarHandler<Number>(), params);
		return rs.intValue();
	}

	@Override
	public List<Order> findByParams(Page pageBean, Map<String, Object> param)
			throws SQLException {
		String sql = "select * from order_info where 1=1";
		List<Object> paramList = new ArrayList<Object>();
		for (String key : param.keySet()) {
			if (!"".equals(param.get(key)) && param.get(key) != null) {
				if ("userId".equals(key)) {
					sql += " and orderUser=?";
				}
				if ("shopId".equals(key)) {
					sql += " and orderShop=?";
				}
				if ("orderId".equals(key)) {
					sql += " and orderId=?";
				} else if ("status".equals(key)) {
					sql += " and orderStatus=?";
				}
				paramList.add(param.get(key));
			}
		}
		sql += " order by " + pageBean.getOrdername() + " "
				+ pageBean.getOrder() + " limit ?,?";
		paramList.add(pageBean.getOffset());
		paramList.add(pageBean.getLimit());
		Object[] params = paramList.toArray();
		return qr.query(sql, new BeanListHandler<Order>(Order.class), params);
	}

	@Override
	public List<OrderItem> findItemById(String orderId) throws SQLException {
		String sql = "select * from order_item where itemOrder=?";
		return qr.query(sql, new BeanListHandler<OrderItem>(OrderItem.class),
				orderId);
	}

	@Override
	public void updateStatusById(String orderId, int status)
			throws SQLException {
		String sql = "update order_info set orderStatus=? where orderId=?";
		Object[] params = { status, orderId };
		qr.update(sql, params);
	}

	@Override
	public Map<String, Map<String, Object>> findProductAndNumById(String orderId) throws SQLException {
		String sql = "select itemNum,itemProduct from order_item where itemOrder=?";
		return qr.query(sql, new KeyedHandler<String>("itemProduct"),orderId);
	}
}
