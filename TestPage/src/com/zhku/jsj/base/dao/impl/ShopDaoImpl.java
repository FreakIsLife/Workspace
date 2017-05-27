package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;


import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;


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
		return qr.query(sql, new BeanHandler<Shop>(Shop.class), bean.getShopId());
	}
}
