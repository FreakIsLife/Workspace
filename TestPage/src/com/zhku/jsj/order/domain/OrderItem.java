package com.zhku.jsj.order.domain;

public class OrderItem {
	private String ItemId;
	private int itemNum;
	private String itemProduct;
	private String itemImg;
	private String itemName;
	private double itemPrice;
	private double itemTotal;
	private String itemOrder;

	public String getItemId() {
		return ItemId;
	}

	public int getItemNum() {
		return itemNum;
	}

	public String getItemProduct() {
		return itemProduct;
	}

	public String getItemImg() {
		return itemImg;
	}

	public String getItemName() {
		return itemName;
	}

	public double getItemPrice() {
		return itemPrice;
	}

	public double getItemTotal() {
		return itemTotal;
	}

	public String getItemOrder() {
		return itemOrder;
	}

	public void setItemId(String itemId) {
		ItemId = itemId;
	}

	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
	}

	public void setItemProduct(String itemProduct) {
		this.itemProduct = itemProduct;
	}

	public void setItemImg(String itemImg) {
		this.itemImg = itemImg;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public void setItemPrice(double itemPrice) {
		this.itemPrice = itemPrice;
	}

	public void setItemTotal(double itemTotal) {
		this.itemTotal = itemTotal;
	}

	public void setItemOrder(String itemOrder) {
		this.itemOrder = itemOrder;
	}
}
