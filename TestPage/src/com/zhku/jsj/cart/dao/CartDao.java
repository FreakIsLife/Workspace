package com.zhku.jsj.cart.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.zhku.jsj.cart.domain.Cart;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.domain.Product;

public interface CartDao {

	/**
	 * 计算某一用户购物车的商品总数
	 * 
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	int countById(String userId) throws SQLException;

	/**
	 * 获取用户购物车的一页数据
	 * 
	 * @param pageBean
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	List<Cart> findById(Page pageBean, String userId) throws SQLException;

	/**
	 * 改变用户购物车的商品数量
	 * 
	 * @param productId
	 * @param num
	 * @param userId
	 * @throws SQLException
	 */
	void changeProdcutNum(String productId, int num, String userId)
			throws SQLException;

	/**
	 * 删除一个购物车商品
	 * 
	 * @param cartId
	 * @param split
	 * @throws SQLException
	 */
	void deleteOneCartProduct(Object[] delIdNum, String cartId)
			throws SQLException;

	/**
	 * 删除多个购物车商品
	 * 
	 * @param params
	 * @param cartId
	 * @throws SQLException
	 */
	void deleteMutiCartProduct(Object[][] params, String cartId)
			throws SQLException;

	/**
	 * 查询购物车是否存在要加入的商品
	 * 
	 * @param buyId
	 * @return
	 * @throws SQLException
	 */
	boolean findProductById(String buyId, String userId) throws SQLException;

	/**
	 * 将新商品加入购物车
	 * 
	 * @param buyId
	 * @param buyNum
	 * @param userId
	 * @throws SQLException
	 */
	void addCartProduct(Product bean, int buyNum, String userId)
			throws SQLException;

	/**
	 * 获取选中的购物车商品
	 * 
	 * @param item
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	/*
	 * List<Cart> getSelectById(Object[] item, String userId) throws
	 * SQLException;
	 */

	/**
	 * 获取购物车中指定商品的Id和数量
	 * 
	 * @param itemId
	 * @param cartId
	 * @return
	 * @throws SQLException
	 */
	Map<String, Map<String, Object>> findIdAndNumById(Object[] itemId,
			String cartId) throws SQLException;

	/**
	 * 移除购物车商品，但不更新商品表
	 * @param itemId
	 * @param cartId
	 * @throws SQLException
	 */
	void removeCartProduct(Object[] itemId, String cartId) throws SQLException;

}
