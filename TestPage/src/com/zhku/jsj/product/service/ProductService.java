package com.zhku.jsj.product.service;

import java.sql.SQLException;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.dao.ProductDao;
import com.zhku.jsj.product.domain.Product;

public class ProductService {
	private ProductDao pd = DaoFactory.getInstance()
			.createDao(ProductDao.class);

	/**
	 * 根据商品名字查找
	 * 
	 * @param pageBean
	 * @param productName
	 * @param userId
	 * @return
	 */
	public List<Product> findProductByName(Page pageBean, String productName,
			String shopId) {
		try {
			if (pageBean.getOrdername() == null
					|| "".equals(pageBean.getOrdername())) {
				pageBean.setOrdername("productId");
			}
			if (productName == null || "".equals(productName)) {
				/*
				 * 没有查询条件，返回全部记录
				 */
				int totalRow = pd.countByShopId(shopId);
				pageBean.setTotalRow(totalRow);
				return pd.findByShop(pageBean, shopId); 
			} else {
				/*
				 * 有查询条件，返回符合条件的总记录数
				 */
				int totalRow = pd.countByShopIdAndName(shopId,productName);
				pageBean.setTotalRow(totalRow);
				return pd.findByShopAndName(pageBean, productName, shopId);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 将productList转换JSONArray
	 * @param productList
	 * @return
	 */
	public String getProductListJson(List<Product> productList) {
		JSONArray productListJson = new JSONArray();
		for (Product product : productList) {
			JSONObject beanJson = new JSONObject();
			beanJson.put("productId", product.getProductId());
			beanJson.put("productImg", product.getProductImg());
			beanJson.put("productLeft", product.getProductLeft());
			beanJson.put("productName", product.getProductName());
			beanJson.put("productPrice", product.getProductPrice());
			beanJson.put("productSale", product.getProductSale());
			beanJson.put("shopId", product.getShopId());
			productListJson.add(beanJson);
		}
		return productListJson.toString();
	}
}
