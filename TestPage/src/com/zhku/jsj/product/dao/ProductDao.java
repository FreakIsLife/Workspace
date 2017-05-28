package com.zhku.jsj.product.dao;

import java.sql.SQLException;
import java.util.List;

import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.domain.Product;

public interface ProductDao {

	/**
	 * 通过商店Id查询商品列表
	 * 
	 * @param pageBean
	 * @param shopId
	 * @return
	 */
	List<Product> findByShop(Page pageBean, String shopId) throws SQLException;

	/**
	 * 通过商店Id和商品名称查询商品列表
	 * 
	 * @param pageBean
	 * @param productName
	 * @param shopId
	 * @return
	 */
	List<Product> findByShopAndName(Page pageBean, String productName,
			String shopId) throws SQLException;

	/**
	 * 统计店铺商品记录数
	 * 
	 * @param shopId
	 * @return
	 */
	int countByShopId(String shopId) throws SQLException;

	/**
	 * 根据查询条件统计商品记录数
	 * 
	 * @param shopId
	 * @param productName
	 * @return
	 */
	int countByShopIdAndName(String shopId, String productName)
			throws SQLException;

	/**
	 * 
	 * @param pageBean
	 * @throws SQLException
	 */
	void getProduct(Page pageBean) throws SQLException;

	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	int count() throws SQLException;

}
