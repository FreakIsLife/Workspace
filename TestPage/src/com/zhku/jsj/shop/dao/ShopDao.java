package com.zhku.jsj.shop.dao;

import java.sql.SQLException;
import java.util.List;

import com.zhku.jsj.shop.domain.Shop;

public interface ShopDao {
	
	/**
	 * 开启店铺,成功返回完整店铺信息
	 * @param bean
	 * @return
	 * @throws SQLException
	 */
	Shop setShop(Shop bean) throws SQLException;

	/**
	 * 通过Id找出多个店铺
	 * @param shop
	 * @return
	 * @throws SQLException
	 */
	List<Shop> findListById(Object[] shopId) throws SQLException;

	/**
	 * 根据店铺Id来查询店铺信息
	 * @param shopId
	 * @return
	 * @throws SQLException
	 */
	Shop findOneById(String shopId) throws SQLException;

	/**
	 * 更新一个店铺的信息
	 * @param bean
	 * @throws SQLException
	 */
	void updateOneInfo(Shop bean) throws SQLException;

}
