package com.zhku.jsj.product.service;

import java.sql.SQLException;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.dao.ProductDao;
import com.zhku.jsj.product.domain.Product;
import com.zhku.jsj.utils.common.CommonUtil;

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
				int totalRow = pd.countByShopIdAndName(shopId, productName);
				pageBean.setTotalRow(totalRow);
				return pd.findByShopAndName(pageBean, productName, shopId);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 将productList转换JSONArray
	 * 
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

	/**
	 * 增加商品
	 * 
	 * @param bean
	 */
	public void addProduct(Product bean) {
		try {
			pd.addOneProduct(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 编辑商品信息
	 * 
	 * @param bean
	 */
	public void editProduct(Product bean) {
		try {
			pd.editOneProduct(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 删除商品
	 * 
	 * @param delData
	 */
	public void deleteProduct(String delData) {
		try {
			String[] delId = delData.split(",");
			if (delId.length == 1) {
				pd.deleteOneProduct(delId[0]);
			} else if (delId.length > 1) {
				Object[][] params = CommonUtil.tranArray(delId);
				pd.deleteMutiProduct(params);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 获取商品
	 * 
	 * @param pageBean
	 */
	public void getProduct(Page pageBean) {
		try {
			pageBean.setTotalRow(pd.count());
			pd.getProduct(pageBean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 通过Id搜索商品
	 * 
	 * @param productId
	 * @return
	 */
	public Product findById(String productId) {
		try {
			return pd.findById(productId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 搜索时返回的商品列表
	 * 
	 * @param pageBean
	 * @param productName
	 * @return
	 */
	public List<Product> searchProduct(Page pageBean, String productName) {
		try {
			if (pageBean.getOrdername() == null
					|| "".equals(pageBean.getOrdername())) {
				pageBean.setOrdername("productId");
			}
			if (productName == null || "".equals(productName)) {
				/*
				 * 没有查询条件，返回全部记录
				 */
				int totalRow = pd.count();
				pageBean.setTotalRow(totalRow);
				return pd.getSearchProduct(pageBean);
			} else {
				/*
				 * 有查询条件，返回符合条件的总记录数
				 */
				int totalRow = pd.countByName(productName);
				pageBean.setTotalRow(totalRow);
				return pd.findByName(pageBean, productName);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
