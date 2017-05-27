package com.zhku.jsj.shop.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.zhku.jsj.product.domain.Product;

public class Shop {
	private String shopId;
	private String shopName;
	private String shopQQ;
	private Date shopStart;
	private List<Product> shopProduct;

	public Shop() {
		super();
		shopProduct = new ArrayList<Product>();
	}
	public String getShopId() {
		return shopId;
	}

	public String getShopName() {
		return shopName;
	}

	public String getShopQQ() {
		return shopQQ;
	}

	public Date getShopStart() {
		return shopStart;
	}

	public void setShopId(String shopId) {
		this.shopId = shopId;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public void setShopQQ(String shopQQ) {
		this.shopQQ = shopQQ;
	}

	public void setShopStart(Date shopStart) {
		this.shopStart = shopStart;
	}

	public List<Product> getShopProduct() {
		return shopProduct;
	}

	public void setShopProduct(List<Product> shopProduct) {
		this.shopProduct = shopProduct;
	}
}
