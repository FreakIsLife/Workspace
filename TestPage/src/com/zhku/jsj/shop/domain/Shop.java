package com.zhku.jsj.shop.domain;

import java.util.Date;

public class Shop {
	private String shopId;
	private String shopName;
	private String shopQQ;
	private Date shopStart;
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
}
