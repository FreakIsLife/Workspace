package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.List;


import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;


import com.zhku.jsj.shop.dao.ShopDao;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.utils.jdbc.TxQueryRunner;

public class ShopDaoImpl implements ShopDao {
	private QueryRunner qr = new TxQueryRunner();

	@Override
	public Shop setShop(Shop bean) throws SQLException {
		String sql = "insert into shop_info value(?,?,?,?)";
		Object[] params = { bean.getShopId(), bean.getShopName(),
				bean.getShopQQ(), null };
		qr.update(sql, params);
		sql = "select * from shop_info where shopId = ?";
		return qr.query(sql, new BeanHandler<Shop>(Shop.class),
				bean.getShopId());
	}

	@Override
	public List<Shop> findListById(Object[] shopId) throws SQLException {
		String sql = "select * from shop_info where shopId in(?";
		for (int i = 0; i < shopId.length - 1; i++) {
			sql += ",?";
		}
		sql += ")";
		return qr.query(sql, new BeanListHandler<Shop>(Shop.class), shopId);
	}
<<<<<<< HEAD
=======

	@Override
	public Shop findOneById(String shopId) throws SQLException {
		String sql = "select * from shop_info where shopId=?";
		return qr.query(sql, new BeanHandler<Shop>(Shop.class), shopId);
	}

	@Override
	public void updateOneInfo(Shop bean) throws SQLException {
		String sql = "update shop_info set shopName=?,shopQQ=? where shopId=?";
		Object[] params = { bean.getShopName(), bean.getShopQQ(),
				bean.getShopId() };
		qr.update(sql, params);
	}

>>>>>>> refs/remotes/origin/master
}
