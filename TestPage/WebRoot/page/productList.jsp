<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>商品</title>
<script type="text/javascript">
	/* 此处做收藏的切换 */
	$(document).ready(
			function() {
				$(".heart").click(
						function(e) {
							e.preventDefault();
							$(this).find('span').toggleClass(
									"glyphicon glyphicon-heart");
							$(this).find('span').toggleClass(
									"glyphicon glyphicon-heart-empty");
						})
			});
</script>
<style type="text/css">
.hover_ora:hover {
	color: orange;
}

.for_price {
	color: #FF4400;
	font-size: 20px;
	font-weight: bold;
}

.fin_num {
	margin-top: 6px;
	float: right;
	font-size: 12px;
}

.cap_div {
	height: 90px;
}
</style>
<!-- 显示数据； -->
<c:if test="${empty pageBean}">暂无商品信息</c:if>
<c:if test="${not empty pageBean}">
	<c:forEach items="${pageBean.beanList}" var="bean">
		<div class="col-sm-6 col-md-3">
			<div class="thumbnail">
				<img style="height:150px" src="${bean.productImg }" alt="通用的占位符缩略图">
				<div class="caption" class="cap_div">
					<b class="for_price">RMB:${bean.productPrice } </b>
					<b class="fin_num">${bean.productSale }人付款</b>
					<br>
					<a class="hover_ora" href="/TestPage/productServlet?method=getProductIntro&productName=encodeURI(${bean.productName})&productPrice=${bean.productPrice}&productSale=${bean.productSale}&productLeft=${bean.productLeft}&productId=${bean.productId}">
					${bean.productName }</a>
				</div>
				<p>
					<a href="#" class="btn btn-primary" role="button">
						加入购物车
						<span class="glyphicon glyphicon-shopping-cart"></span>
					</a>
					&nbsp;&nbsp;&nbsp;
					<a href="#" class="btn btn-default btn-md heart" role="button">
						<span class="glyphicon glyphicon-heart-empty"></span>
					</a>
				</p>
			</div>
		</div>
	</c:forEach>
	<div></div>
	
	<div align=center >
		<a class="flushPage" href="/TestPage/productServlet?method=getProduct&pageNum=1">首页</a>
		&nbsp;&nbsp;&nbsp;

		<c:if test="${pageBean.pageNum==1}">
				上一页&nbsp;&nbsp;&nbsp;
			</c:if>
		<c:if test="${pageBean.pageNum!=1}">
			<a class="flushPage"
				href="/TestPage/productServlet?method=getProduct&pageNum=${pageBean.pageNum-1}">上一页</a>&nbsp;&nbsp;&nbsp;
			</c:if>
			<span>第${pageBean.pageNum}页/共${pageBean.totalPage}页</span>&nbsp;&nbsp;&nbsp;
		<c:if test="${pageBean.pageNum==pageBean.totalPage}">
				下一页&nbsp;&nbsp;&nbsp;
			</c:if>
		<c:if test="${pageBean.pageNum!=pageBean.totalPage}">
			<a class="flushPage"
				href="/TestPage/productServlet?method=getProduct&pageNum=${pageBean.pageNum+1 }">下一页</a>&nbsp;&nbsp;&nbsp;
			</c:if>
		<a class="flushPage"
			href="/TestPage/productServlet?method=getProduct&pageNum=${pageBean.totalPage }">尾页</a>
		&nbsp;&nbsp;&nbsp;
	    </c:if>
	    
	</div>