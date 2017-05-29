package com.zhku.jsj.cart.domain;

public class Cart {
	private String cartId;
	private String cartItem;
	private int cartNum;
	private double cartPrice;
	private String cartImg;
	private String cartName;

	public String getCartId() {
		return cartId;
	}

	public String getCartItem() {
		return cartItem;
	}

	public int getCartNum() {
		return cartNum;
	}

	public double getCartPrice() {
		return cartPrice;
	}

	public String getCartImg() {
		return cartImg;
	}

	public String getCartName() {
		return cartName;
	}

	public void setCartId(String cartId) {
		this.cartId = cartId;
	}

	public void setCartItem(String cartItem) {
		this.cartItem = cartItem;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public void setCartPrice(double cartPrice) {
		this.cartPrice = cartPrice;
	}

	public void setCartImg(String cartImg) {
		this.cartImg = cartImg;
	}

	public void setCartName(String cartName) {
		this.cartName = cartName;
	}
}
