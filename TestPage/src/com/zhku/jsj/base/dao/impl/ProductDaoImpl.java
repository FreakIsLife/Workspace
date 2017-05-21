package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.dao.ProductDao;
import com.zhku.jsj.product.domain.Product;
import com.zhku.jsj.utils.jdbc.TxQueryRunner;

public class ProductDaoImpl implements ProductDao {
	private QueryRunner qr = new TxQueryRunner();

	@Override
	public List<Product> findByShop(Page pageBean, String shopId)
			throws SQLException {
		String sql = "select * from ( select * from product_info where shopId=?) a order by ? ? limit ?,?";
		Object[] params = { shopId, pageBean.getOrdername(),
				pageBean.getOrder(), pageBean.getOffset(), pageBean.getLimit() };
		return qr.query(sql, new BeanListHandler<Product>(Product.class),
				params);
	}

	@Override
	public List<Product> findByShopAndName(Page pageBean, String productName,
			String shopId) throws SQLException {
		String sql = "select * from ( select * from product_info where shopId=? and productName like ?) a order by ? ? limit ?,?";
		Object[] params = { shopId, "%" + productName + "%",
				pageBean.getOrdername(), pageBean.getOrder(),
				pageBean.getOffset(), pageBean.getLimit() };
		return qr.query(sql, new BeanListHandler<Product>(Product.class),
				params);
	}

	@Override
	public int countByShopId(String shopId) throws SQLException {
		String sql = "select count(*) from product_info where shopId = ?";
		Number count = qr.query(sql, new ScalarHandler<Number>(), shopId);
		return count.intValue();
	}

	@Override
	public int countByShopIdAndName(String shopId, String productName)
			throws SQLException {
		String sql = "select count(*) from product_info where shopId = ? and productName like";
		Number count = qr.query(sql, new ScalarHandler<Number>(), shopId, "%"
				+ productName + "%");
		return count.intValue();
	}
}
