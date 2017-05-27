package com.zhku.jsj.order.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {
	private String orderId;
	private int orderStatus;
	private double orderTotal;
	private String orderAddress;
	private String orderUser;
	private Date orderTime;
	private String orderShop;
	private List<OrderItem> orderItem;

	public Order() {
		super();
		orderItem = new ArrayList<OrderItem>();
	}

	public String getOrderId() {
		return orderId;
	}

	public int getOrderStatus() {
		return orderStatus;
	}

	public double getOrderTotal() {
		return orderTotal;
	}

	public String getOrderAddress() {
		return orderAddress;
	}

	public String getOrderUser() {
		return orderUser;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public List<OrderItem> getOrderItem() {
		return orderItem;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public void setOrderTotal(double orderTotal) {
		this.orderTotal = orderTotal;
	}

	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}

	public void setOrderUser(String orderUser) {
		this.orderUser = orderUser;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public void setOrderItem(List<OrderItem> orderItem) {
		this.orderItem = orderItem;
	}

	public String getOrderShop() {
		return orderShop;
	}

	public void setOrderShop(String orderShop) {
		this.orderShop = orderShop;
	}
}
