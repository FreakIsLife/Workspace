<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href='<c:url value="/css/navSide.css"></c:url>' rel="stylesheet">
<ul class="nav nav-pills nav-stacked">
	<li class="active kind" data-toggle="tab">
		<a class="child" data-toggle="collapse" href="#sub-item-1">
			<span class="glyphicon glyphicon-list"></span>
			个人资料
			<span class="icon pull-right">
				<em class="glyphicon glyphicon-s glyphicon-plus"></em>
			</span>
		</a>
		<ul class="nav nav-pills nav-stacked collapse" id="sub-item-1">
			<li class="active" data-toggle="tab">
				<a id="information" class="flushPage" href='<c:url value="/user/information.jsp"></c:url>'>
					<span class="glyphicon glyphicon-share-alt"></span>
					个人信息
				</a>
			</li>
			<li data-toggle="tab">
				<a id="changePassword" class="flushPage" href='<c:url value="/user/changePassword.jsp"></c:url>'>
					<span class="glyphicon glyphicon-share-alt"></span>
					修改密码
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					地址管理
				</a>
			</li>
		</ul>
	</li>
	<li class="kind" data-toggle="tab">
		<a class="child" data-toggle="collapse" href="#sub-item-2">
			<span class="glyphicon glyphicon-list"></span>
			我的管理
			<span class="icon pull-right">
				<em class="glyphicon glyphicon-s glyphicon-plus"></em>
			</span>
		</a>
		<ul class="nav nav-pills nav-stacked collapse" id="sub-item-2">
			<li class="active" data-toggle="tab">
				<a id="myCart" class="flushPage" href='<c:url value="/user/myCart.jsp"></c:url>'>
					<span class="glyphicon glyphicon-share-alt"></span>
					我的购物车
				</a>
			</li>
			<li data-toggle="tab">
				<a id="myOrder" class="flushPage" href='<c:url value="/user/myOrder.jsp"></c:url>'>
					<span class="glyphicon glyphicon-share-alt"></span>
					我的订单
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					我的收藏
				</a>
			</li>
		</ul>
	</li>
	<c:if test="${loginUser.userIsShop==0 }">
		<li data-toggle="tab">
			<a id="setShop" class="flushPage" href='<c:url value="/user/setShop.jsp"></c:url>'>我要开店</a>
		</li>
	</c:if>
	<c:if test="${loginUser.userIsShop==1 }">
		<li class="kind" data-toggle="tab">
			<a class="child" data-toggle="collapse" href="#sub-item-3">
				<span class="glyphicon glyphicon-list"></span>
				我的店铺
				<span class="icon pull-right">
					<em class="glyphicon glyphicon-s glyphicon-plus"></em>
				</span>
			</a>
			<ul class="nav nav-pills nav-stacked collapse" id="sub-item-3">
				<li data-toggle="tab">
					<a id="shopMainPage" class="flushPage" href='<c:url value="/shop/shopMainPage.jsp"></c:url>'>
						<span class="glyphicon glyphicon-share-alt"></span>
						店铺首页
					</a>
				</li>
				<li data-toggle="tab">
					<a id="shopInfo" class="flushPage" href='<c:url value="/shop/shopInfo.jsp"></c:url>'>
						<span class="glyphicon glyphicon-share-alt"></span>
						店铺信息
					</a>
				</li>
				<li class="active" data-toggle="tab">
					<a id="shopProduct" class="flushPage" href='<c:url value="/shop/shopProduct.jsp"></c:url>'>
						<span class="glyphicon glyphicon-share-alt"></span>
						上架商品
					</a>
				</li>
				<li data-toggle="tab">
					<a id="shopOrder" class="flushPage" href='<c:url value="/shop/shopOrder.jsp"></c:url>'>
						<span class="glyphicon glyphicon-share-alt"></span>
						店铺订单
					</a>
				</li>
			</ul>
		</li>
	</c:if>
</ul>
<script src='<c:url value="/js/navSider.js"></c:url>'></script>