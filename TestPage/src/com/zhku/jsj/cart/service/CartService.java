package com.zhku.jsj.cart.service;

import java.sql.SQLException;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.cart.dao.CartDao;
import com.zhku.jsj.cart.domain.Cart;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.dao.ProductDao;
import com.zhku.jsj.product.domain.Product;
import com.zhku.jsj.utils.common.CommonUtil;
import com.zhku.jsj.utils.jdbc.JdbcUtils;

public class CartService {

	private CartDao cd = DaoFactory.getInstance().createDao(CartDao.class);
	private ProductDao pd = DaoFactory.getInstance()
			.createDao(ProductDao.class);

	/**
	 * 根据pageBean的参数以及用户Id查询所属购物车
	 * 
	 * @param pageBean
	 * @param userId
	 * @return
	 */
	public List<Cart> findCartById(Page pageBean, String userId) {
		try {
			int totalRow = cd.countById(userId);
			pageBean.setTotalRow(totalRow);
			return cd.findById(pageBean, userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 将Cart的List转换成Json数组
	 * 
	 * @param cartList
	 * @return
	 */
	public String getCartListJson(List<Cart> cartList) {
		JSONArray cartListJson = new JSONArray();
		for (Cart cart : cartList) {
			JSONObject beanJson = new JSONObject();
			beanJson.put("cartId", cart.getCartId());
			beanJson.put("cartImg", cart.getCartImg());
			beanJson.put("cartItem", cart.getCartItem());
			beanJson.put("cartName", cart.getCartName());
			beanJson.put("cartNum", cart.getCartNum());
			beanJson.put("cartPrice", cart.getCartPrice());
			cartListJson.add(beanJson);
		}
		return cartListJson.toString();
	}

	/**
	 * 改变购物车商品的数量
	 * 
	 * @1. 同时改变商品表和购物车表
	 * @2. 商品数量不足时不可以改变
	 * @param productId
	 * @param num
	 * @param userId
	 * @return
	 */
	public String changeNum(String productId, int num, String userId) {
		try {
			String msg = null;
			JdbcUtils.beginTransaction();
			int currentNum = pd.findProductNum(productId);
			if (currentNum < num) {
				msg = "商品数量不足！";
			} else {
				pd.changeProductNum(productId, num);
				cd.changeProdcutNum(productId, num, userId);
			}
			JdbcUtils.commitTransaction();
			return msg;
		} catch (SQLException e) {
			try {
				JdbcUtils.rollbackTransaction();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}

	/**
	 * 删除购物车商品
	 * 
	 * @param delData
	 */
	public void deleteCartProduct(String delData, String cartId) {
		try {
			JdbcUtils.beginTransaction();
			String[] delIdNum = delData.split(",");
			if (delIdNum.length == 1) {
				cd.deleteOneCartProduct(delIdNum[0].split("-"),cartId);
			} else {
				Object[][] params = CommonUtil.tranArray(delIdNum);
				cd.deleteMutiCartProduct(params,cartId);
			}
			JdbcUtils.commitTransaction();
		} catch (SQLException e) {
			try {
				JdbcUtils.rollbackTransaction();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}

	/**
	 * 添加商品到购物车
	 * 
	 * @param buyId
	 * @param buyNum
	 * @param userId
	 */
	public String addCartProduct(String buyId, int buyNum, String userId) {
		try {
			JdbcUtils.beginTransaction();
			String msg = null;
			int currentNum = pd.findProductNum(buyId);
			if (currentNum < buyNum) {
				msg = "商品数量不足！";
			} else {
				pd.changeProductNum(buyId, -buyNum);
				if (cd.findProductById(buyId, userId)) {
					cd.changeProdcutNum(buyId, buyNum, userId);
				} else {
					Product bean = pd.findById(buyId);
					cd.addCartProduct(bean, buyNum, userId);
				}
			}
			JdbcUtils.commitTransaction();
			return msg;
		} catch (SQLException e) {
			try {
				JdbcUtils.rollbackTransaction();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}
}
