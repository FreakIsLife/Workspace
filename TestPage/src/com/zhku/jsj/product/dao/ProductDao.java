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
	 * 增加一个商品
	 * 
	 * @param bean
	 * @throws SQLException
	 */
	void addOneProduct(Product bean) throws SQLException;

	/**
	 * 编辑一个商品
	 * 
	 * @param bean
	 * @throws SQLException
	 */
	void editOneProduct(Product bean) throws SQLException;

	/**
	 * 删除一个商品
	 * 
	 * @param string
	 * @throws SQLException
	 */
	void deleteOneProduct(String delId) throws SQLException;

	/**
	 * 删除多个商品
	 * 
	 * @param delId
	 * @throws SQLException
	 */
	void deleteMutiProduct(Object[][] params) throws SQLException;

	/**
	 * 查询商品的数量
	 * 
	 * @param productId
	 * @return
	 * @throws SQLException
	 */
	int findProductNum(String productId) throws SQLException;

	/**
	 * 更改商品的数量
	 * 
	 * @param productId
	 * @param num
	 * @throws SQLException
	 */
	void changeProductNum(String productId, int num) throws SQLException;

	/**
	 * 通过商品Id查询商品信息
	 * 
	 * @param productId
	 * @return
	 * @throws SQLException
	 */
	Product findById(String productId) throws SQLException;

	/**
	 * 批量查找商品
	 * 
	 * @param itemId
	 * @return
	 * @throws SQLException
	 */
	List<Product> findListById(Object[] productId) throws SQLException;

	/**
	 * 获取商品
	 * 
	 * @param pageBean
	 * @throws SQLException
	 */
	void getProduct(Page pageBean) throws SQLException;

	/**
	 * 返回总记录数
	 * 
	 * @return
	 * @throws SQLException
	 */
	int count() throws SQLException;

	/**
	 * 搜索时返回List列表
	 * @param pageBean
	 * @return
	 * @throws SQLException
	 */
	List<Product> getSearchProduct(Page pageBean) throws SQLException;

	/**
	 * 统计查询的总条数
	 * @param productName
	 * @return
	 * @throws SQLException
	 */
	int countByName(String productName) throws SQLException;

	/**
	 * 返回相关产品名的List
	 * @param pageBean
	 * @param productName
	 * @return
	 * @throws SQLException
	 */
	List<Product> findByName(Page pageBean, String productName) throws SQLException;

	/**
	 * 更新销量
	 * @param params
	 * @throws SQLException
	 */
	void updateSale(Object[][] params) throws SQLException;

}
