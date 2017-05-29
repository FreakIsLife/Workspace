package com.zhku.jsj.pager;

import java.util.List;

import com.zhku.jsj.shop.domain.Shop;

public class PageShop {
	private int pageNum; //当前页数
	private int totalPages; //总的页数
	private int totalRows;  //总行数
	private int pageSize; //每页显示的行数
	private List<Shop> shop;  //每页显示的数据
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public List<Shop> getShop() {
		return shop;
	}
	public void setShop(List<Shop> shop) {
		this.shop = shop;
	}


}
