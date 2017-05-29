package com.zhku.jsj.shop.service;

import java.sql.SQLException;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.shop.dao.ShopDao;
import com.zhku.jsj.shop.domain.Shop;

public class ShopService {

	private ShopDao sd = DaoFactory.getInstance().createDao(ShopDao.class);

	/**
	 * 根据店铺Id获取店铺信息
	 * 
	 * @param userId
	 * @return
	 */
	public Shop getShopInfo(String shopId) {
		try {
			return sd.findOneById(shopId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 保存店铺修改的信息
	 * @param bean
	 */
	public void saveInfo(Shop bean) {
		try {
			sd.updateOneInfo(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
