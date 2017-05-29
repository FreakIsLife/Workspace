package com.zhku.jsj.order.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.cart.dao.CartDao;
import com.zhku.jsj.order.dao.OrderDao;
import com.zhku.jsj.order.domain.Order;
import com.zhku.jsj.order.domain.OrderItem;
import com.zhku.jsj.pager.Page;
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
	 * 根据商品Id找出与其相关的店铺 并将所有商品和店铺组合在一起 形成店铺的List表，且店铺下有商品List
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
	 * 
	 * @param itemJson
	 * @param userId
	 * @return
	 */
	public Map<String, Map<String, Object>> findInCart(JSONArray itemJson,
			String userId) {
		try {
			Object[] itemId = new Object[itemJson.size()];
			int index = 0;
			for (Object object : itemJson) {
				itemId[index++] = object;
			}
			return cd.findIdAndNumById(itemId, userId);
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
			cd.removeCartProduct(itemId, userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 查询我的订单
	 * 
	 * @param pageBean
	 * @param orderId
	 * @param status
	 * @param userId
	 * @return
	 */
	public List<Order> findMyOrder(Page pageBean, String orderId,
			String status, String userId) {
		try {
			if ("".equals(pageBean.getOrdername())
					|| pageBean.getOrdername() == null) {
				pageBean.setOrdername("orderStatus");
			}
			int orderStatus = OrderStatus.valueOf(status).ordinal();
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("orderId", orderId);
			if (orderStatus != 0) {
				params.put("status", orderStatus);
			}
			params.put("userId", userId);
			// 参数过多，将参数封装在Map交与持久层处理
			int totalRow = od.countByParams(params);
			pageBean.setTotalRow(totalRow);
			return od.findByParams(pageBean, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 将OrderList转化成Json字符串
	 * 
	 * @param orderList
	 * @return
	 */
	public String getOrderListJson(List<Order> orderList) {
		JSONArray orderListJson = new JSONArray();
		SimpleDateFormat spf = new SimpleDateFormat("yyyy-MM-dd");
		for (Order order : orderList) {
			JSONObject beanJson = new JSONObject();
			beanJson.put("orderAddress", order.getOrderAddress());
			beanJson.put("orderId", order.getOrderId());
			beanJson.put("orderShop", order.getOrderShop());
			beanJson.put("orderStatus", order.getOrderStatus());
			String orderTime = spf.format(order.getOrderTime());
			beanJson.put("orderTime", orderTime);
			beanJson.put("orderTotal", order.getOrderTotal());
			beanJson.put("orderUser", order.getOrderUser());
			orderListJson.add(beanJson);
		}
		return orderListJson.toString();
	}

	/**
	 * 获取每一条订单记录下的订单项
	 * 
	 * @param orderId
	 * @return
	 */
	public List<OrderItem> findOrderItem(String orderId) {
		try {
			return od.findItemById(orderId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 将OrderItem的List转换成Json字符串
	 * 
	 * @param itemList
	 * @return
	 */
	public String getItemListJson(List<OrderItem> itemList) {
		JSONArray itemListJson = new JSONArray();
		for (OrderItem item : itemList) {
			JSONObject beanJson = new JSONObject();
			beanJson.put("itemId", item.getItemId());
			beanJson.put("itemImg", item.getItemImg());
			beanJson.put("itemName", item.getItemName());
			beanJson.put("itemNum", item.getItemNum());
			beanJson.put("itemOrder", item.getItemOrder());
			beanJson.put("itemPrice", item.getItemPrice());
			beanJson.put("itemProduct", item.getItemProduct());
			beanJson.put("itemTotal", item.getItemTotal());
			itemListJson.add(beanJson);
		}
		return itemListJson.toString();
	}

	/**
	 * 获取店铺的订单
	 * 
	 * @param pageBean
	 * @param orderId
	 * @param status
	 * @param userId
	 * @return
	 */
	public List<Order> findShopOrder(Page pageBean, String orderId,
			String status, String shopId) {
		try {
			if ("".equals(pageBean.getOrdername())
					|| pageBean.getOrdername() == null) {
				pageBean.setOrdername("orderStatus");
			}
			int orderStatus = OrderStatus.valueOf(status).ordinal();
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("orderId", orderId);
			if (orderStatus != 0) {
				params.put("status", orderStatus);
			}
			params.put("shopId", shopId);
			// 参数过多，将参数封装在Map交与持久层处理
			int totalRow = od.countByParams(params);
			pageBean.setTotalRow(totalRow);
			return od.findByParams(pageBean, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据订单号更新订单状态
	 * 
	 * @param orderId
	 * @param orderStatus
	 */
	public void updateStatus(String orderId, String Status) {
		try {
			int orderStatus = OrderStatus.valueOf(Status).ordinal();
			if (orderStatus == 4) {
				Map<String, Map<String, Object>> productIdAndNum = od
						.findProductAndNumById(orderId);
				Object[][] params = new Object[productIdAndNum.keySet().size()][2];
				int index = 0;
				for (String key : productIdAndNum.keySet()) {
					Map<String, Object> map = productIdAndNum.get(key);
					List<Object> param = new ArrayList<Object>();
					for (String subKey : map.keySet()) {
						param.add(map.get(subKey));
					}
					params[index++] = param.toArray();
				}
				pd.updateSale(params);
			}
			od.updateStatusById(orderId, orderStatus);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}

enum OrderStatus {
	all, pay, send, certain, success, cancel;
}
