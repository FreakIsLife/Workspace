package com.zhku.jsj.order.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.cart.dao.CartDao;
import com.zhku.jsj.order.dao.OrderDao;
import com.zhku.jsj.order.domain.Order;
import com.zhku.jsj.order.domain.OrderItem;
import com.zhku.jsj.product.dao.ProductDao;
import com.zhku.jsj.product.domain.Product;
import com.zhku.jsj.shop.dao.ShopDao;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.utils.common.CommonUtil;
import com.zhku.jsj.utils.jdbc.JdbcUtils;

public class OrderService {
	private OrderDao od = DaoFactory.getInstance().createDao(OrderDao.class);
	private CartDao cd = DaoFactory.getInstance().createDao(CartDao.class);
	private ShopDao sd = DaoFactory.getInstance().createDao(ShopDao.class);
	private ProductDao pd = DaoFactory.getInstance()
			.createDao(ProductDao.class);

	/**
	 * 
	 * @param itemJson
	 * @return
	 */
	public List<Shop> findAndMix(JSONArray itemJson) {
		try {
			JdbcUtils.beginTransaction();
			Object[] itemId = new Object[itemJson.size()];
			int index = 0;
			for (Object object : itemJson) {
				itemId[index++] = object;
			}
			// 找出所有商品详细信息
			List<Product> productList = pd.findListById(itemId);
			// 去除重复店铺
			Set<String> shopSet = new HashSet<String>();
			for (Product product : productList) {
				shopSet.add(product.getShopId());
			}
			Object[] shopId = shopSet.toArray();
			// 找出所有店铺
			List<Shop> shopList = sd.findListById(shopId);
			for (Product product : productList) {
				for (Shop shop : shopList) {
					if (shop.getShopId().equals(product.getShopId())) {
						shop.getShopProduct().add(product);
					}
				}
			}
			JdbcUtils.commitTransaction();
			return shopList;
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
	 * 添加订单
	 * 
	 * @1. 给每个店铺生成自己的订单UUID
	 * @2.
	 * @param shopList
	 * @param bean
	 * @param itemNum
	 */
	public void addOrder(List<Shop> shopList, Order bean,
			Map<String, Map<String, Object>> itemNum) {
		try {
			JdbcUtils.beginTransaction();
			List<Order> orderList = new ArrayList<Order>();
			for (Shop shop : shopList) {
				Order beanOrder = new Order();
				beanOrder.setOrderAddress(bean.getOrderAddress());
				beanOrder.setOrderUser(bean.getOrderUser());
				beanOrder.setOrderId(CommonUtil.getUUID());
				beanOrder.setOrderShop(shop.getShopId());
				beanOrder.setOrderStatus(bean.getOrderStatus());
				double totalPrice = 0;
				for (Product product : shop.getShopProduct()) {
					int cartNum = (int) itemNum.get(product.getProductId())
							.get("cartNum");
					OrderItem beanItem = new OrderItem();
					beanItem.setItemId(CommonUtil.getUUID());
					beanItem.setItemImg(product.getProductImg());
					beanItem.setItemName(product.getProductName());
					beanItem.setItemNum(cartNum);
					beanItem.setItemOrder(beanOrder.getOrderId());
					beanItem.setItemPrice(product.getProductPrice());
					beanItem.setItemProduct(product.getProductId());
					double singleTotal = cartNum * beanItem.getItemPrice();
					beanItem.setItemTotal(singleTotal);
					totalPrice += singleTotal;
					beanOrder.getOrderItem().add(beanItem);
				}
				beanOrder.setOrderTotal(totalPrice);
				orderList.add(beanOrder);
			}
			od.addOrder(orderList);
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
	 * 获取购物车中商品Id和数量的Map
	 * @param itemJson
	 * @param userId
	 * @return
	 */
	public Map<String, Map<String, Object>> findInCart(JSONArray itemJson,String userId) {
		try {
			Object[] itemId = new Object[itemJson.size()];
			int index = 0;
			for (Object object : itemJson) {
				itemId[index++] = object;
			}
			return cd.findIdAndNumById(itemId,userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 
	 * @param itemJson
	 * @param userId
	 */
	public void delCartItem(JSONArray itemJson, String userId) {
		try {
			Object[] itemId = new Object[itemJson.size()];
			int index = 0;
			for (Object object : itemJson) {
				itemId[index++] = object;
			}
			cd.removeCartProduct(itemId,userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
