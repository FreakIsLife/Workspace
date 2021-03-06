package com.zhku.jsj.pager;

import java.util.List;

/**
 * 分页Bean！
 * 
 * @author Administrator
 */
public class Page {
	private int limit; // 页面大小
	private int offset; // 当前页偏移量
	private int totalRow; // 总记录数
	private int totalPage; // 总页数
	private int pageNum; // 当前页面
	private String order; // 排序方式
	private String ordername; // 排序列名
	private List<?> beanList;

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalPage() {
		this.totalPage = totalRow / limit;
		return totalRow % limit == 0 ? totalPage : totalPage + 1;
	}

	public int getLimit() {
		return limit;
	}

	public int getOffset() {
		return offset;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public String getOrder() {
		return order;
	}

	public String getOrdername() {
		return ordername;
	}

	public List<?> getBeanList() {
		return beanList;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public void setOrdername(String ordername) {
		this.ordername = ordername;
	}

	public void setBeanList(List<?> beanList) {
		this.beanList = beanList;
	}
}
