package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.KeyedHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.zhku.jsj.cart.dao.CartDao;
import com.zhku.jsj.cart.domain.Cart;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.domain.Product;
import com.zhku.jsj.utils.jdbc.TxQueryRunner;

public class CartDaoImpl implements CartDao {
	private QueryRunner qr = new TxQueryRunner();

	@Override
	public int countById(String userId) throws SQLException {
		String sql = "select count(*) from cart_info where cartId=?";
		Number rs = qr.query(sql, new ScalarHandler<Number>(), userId);
		return rs.intValue();
	}

	@Override
	public List<Cart> findById(Page pageBean, String userId)
			throws SQLException {
		String sql = "select * from cart_info where cartId=? limit ?,?";
		Object[] params = { userId, pageBean.getOffset(), pageBean.getLimit() };
		return qr.query(sql, new BeanListHandler<Cart>(Cart.class), params);
	}

	@Override
	public void changeProdcutNum(String productId, int num, String userId)
			throws SQLException {
		String sql = "update cart_info set cartNum = cartNum + ? where cartId = ? and cartItem = ?";
		Object[] params = { num, userId, productId };
		qr.update(sql, params);
	}

	@Override
	public void deleteOneCartProduct(Object[] delIdNum, String cartId)
			throws SQLException {
		String sql = "delete from cart_info where cartItem = ? and cartId = ?";
		qr.update(sql, delIdNum[0], cartId);
		sql = "update product_info set productLeft = productLeft + ? where productId=?";
		qr.update(sql, delIdNum[1], delIdNum[0]);
	}

	@Override
	public void deleteMutiCartProduct(Object[][] params, String cartId)
			throws SQLException {
		String sql = "delete from cart_info where cartItem = ? and cartNum = ? and cartId = '"
				+ cartId + "'";
		qr.batch(sql, params);
		for (Object[] objects : params) {
			Object temp = objects[0];
			objects[0] = objects[1];
			objects[1] = temp;
		}
		sql = "update product_info set productLeft = productLeft + ? where productId=?";
		qr.batch(sql, params);
	}

	@Override
	public boolean findProductById(String buyId, String userId)
			throws SQLException {
		String sql = "select count(*) from cart_info where cartItem=? and cartId=?";
		Number rs = qr.query(sql, new ScalarHandler<Number>(), buyId, userId);
		return rs.intValue() != 0;
	}

	@Override
	public void addCartProduct(Product bean, int buyNum, String userId)
			throws SQLException {
		String sql = "insert into cart_info value(?,?,?,?,?,?)";
		Object[] params = { userId, bean.getProductId(), buyNum,
				bean.getProductPrice(), bean.getProductImg(),
				bean.getProductName() };
		qr.update(sql, params);
	}

	/*
	 * @Override public List<Cart> getSelectById(Object[] item, String userId)
	 * throws SQLException { String sql =
	 * "select * from cart_info where cartId=? and cartItem in (?"; for (int i =
	 * 0; i < item.length - 1; i++) { sql += ",?"; } sql += ")"; return
	 * qr.query(sql, new BeanListHandler<Cart>(Cart.class), userId,item); }
	 */

	@Override
	public Map<String, Map<String, Object>> findIdAndNumById(Object[] itemId,
			String cartId) throws SQLException {
		String sql = "select cartItem,cartNum from cart_info where cartId=? and cartItem in (?";
		for (int i = 0; i < itemId.length - 1; i++) {
			sql += ",?";
		}
		sql += ")";
		Object[] params = new Object[itemId.length + 1];
		params[0] = cartId;
		for (int i = 1; i < params.length; i++) {
			params[i] = itemId[i - 1];
		}
		return qr.query(sql, new KeyedHandler<String>("cartItem"), params);
	}

	@Override
	public void removeCartProduct(Object[] itemId, String cartId)
			throws SQLException {
		String sql = "delete from cart_info where cartId=? and cartItem in (?";
		for (int i = 0; i < itemId.length - 1; i++) {
			sql += ",?";
		}
		sql += ")";
		Object[] params = new Object[itemId.length + 1];
		params[0] = cartId;
		for (int i = 1; i < params.length; i++) {
			params[i] = itemId[i - 1];
		}
		qr.update(sql, params);
	}
}
