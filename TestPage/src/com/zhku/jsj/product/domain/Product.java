package com.zhku.jsj.product.domain;

public class Product {
	private String productId;
	private String productName;
	private double productPrice;
	private int productLeft;
	private int productSale;
	private String productImg;
	private String shopId;

	public String getProductId() {
		return productId;
	}

	public String getProductName() {
		return productName;
	}

	public double getProductPrice() {
		return productPrice;
	}

	public int getProductLeft() {
		return productLeft;
	}

	public int getProductSale() {
		return productSale;
	}

	public String getProductImg() {
		return productImg;
	}

	public String getShopId() {
		return shopId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public void setProductPrice(double productPrice) {
		this.productPrice = productPrice;
	}

	public void setProductLeft(int productLeft) {
		this.productLeft = productLeft;
	}

	public void setProductSale(int productSale) {
		this.productSale = productSale;
	}

	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}

	public void setShopId(String shopId) {
		this.shopId = shopId;
	}

}
