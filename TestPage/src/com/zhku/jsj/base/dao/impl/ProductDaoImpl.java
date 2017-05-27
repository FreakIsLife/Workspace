package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
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
		String sql = "select * from ( select * from product_info where shopId=?) a order by "
				+ pageBean.getOrdername()
				+ " "
				+ pageBean.getOrder()
				+ " limit ?,?";
		Object[] params = { shopId, pageBean.getOffset(), pageBean.getLimit() };
		return qr.query(sql, new BeanListHandler<Product>(Product.class),
				params);
	}

	@Override
	public List<Product> findByShopAndName(Page pageBean, String productName,
			String shopId) throws SQLException {
		String sql = "select * from ( select * from product_info where shopId=? and productName like ?) a order by "
				+ pageBean.getOrdername()
				+ " "
				+ pageBean.getOrder()
				+ " limit ?,?";
		Object[] params = { shopId, "%" + productName + "%",
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
		String sql = "select count(*) from product_info where shopId = ? and productName like ?";
		Number count = qr.query(sql, new ScalarHandler<Number>(), shopId, "%"
				+ productName + "%");
		return count.intValue();
	}

	@Override
	public void addOneProduct(Product bean) throws SQLException {
		String sql = "insert into product_info value(?,?,?,?,?,?,?)";
		Object[] params = { bean.getProductId(), bean.getProductName(),
				bean.getProductPrice(), bean.getProductLeft(),
				bean.getProductSale(), bean.getProductImg(), bean.getShopId() };
		qr.update(sql, params);
	}

	@Override
	public void editOneProduct(Product bean) throws SQLException {
		String sql = "update product_info set productName=?,productPrice=?,productLeft=?,productImg=? where shopId=? and productId=?";
		Object[] params = { bean.getProductName(), bean.getProductPrice(),
				bean.getProductLeft(), bean.getProductImg(), bean.getShopId(),
				bean.getProductId() };
		qr.update(sql, params);
	}

	@Override
	public void deleteOneProduct(String delId) throws SQLException {
		String sql = "delete from product_info where productId = ?";
		qr.update(sql, delId);

	}

	@Override
	public void deleteMutiProduct(Object[][] params) throws SQLException {
		String sql = "delete from product_info where productId = ?";
		qr.batch(sql, params);

	}

	@Override
	public int findProductNum(String productId) throws SQLException {
		String sql = "select productLeft from product_info where productId = ?";
		Number rs = qr.query(sql, new ScalarHandler<Number>(), productId);
		if (rs == null) {
			rs = 0;
		}
		return rs.intValue();
	}

	@Override
	public void changeProductNum(String productId, int num) throws SQLException {
		String sql = "update product_info set productLeft = productLeft - ? where productId = ?";
		Object[] params = { num, productId };
		qr.update(sql, params);
	}

	@Override
	public Product findById(String productId) throws SQLException {
		String sql = "select * from product_info where productId=?";
		return qr
				.query(sql, new BeanHandler<Product>(Product.class), productId);
	}

	@Override
	public List<Product> findListById(Object[] productId) throws SQLException {
		String sql = "select * from product_info where productId in (?";
		for (int i = 0; i < productId.length - 1; i++) {
			sql += ",?";
		}
		sql += ")";
		return qr.query(sql, new BeanListHandler<Product>(Product.class),
				productId);
	}
}
