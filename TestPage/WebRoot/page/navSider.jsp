<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href='<c:url value="/css/navSide.css"></c:url>' rel="stylesheet">
<ul class="nav nav-pills nav-stacked">
	<li class="active kind" data-toggle="tab">
		<a class="child" data-toggle="collapse" href="#sub-item-1">
			<span class="glyphicon glyphicon-list"></span>
			书类
			<span class="icon pull-right">
				<em class="glyphicon glyphicon-s glyphicon-plus"></em>
			</span>
		</a>
		<ul class="nav nav-pills nav-stacked collapse" id="sub-item-1">
			<li class="active" data-toggle="tab">
				<a id="bookInfo" class="flushPage"
					href='<c:url value="/page/bookInfo.jsp"></c:url>'>童话类 </a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- 	<span class="glyphicon glyphicon-share-alt"></span> -->
					<!-- Sub Item 2 -->
					科技类
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- 	<span class="glyphicon glyphicon-share-alt"></span> -->
					<!-- 	Sub Item 3 -->
					文学类
				</a>
			</li>
		</ul>
	</li>

	<li class="kind" data-toggle="tab">
		<a class="child" data-toggle="collapse" href="#sub-item-2">
			<span class="glyphicon glyphicon-list"></span>
			鞋类
			<span class="icon pull-right">
				<em class="glyphicon glyphicon-s glyphicon-plus"></em>
			</span>
		</a>
		<ul class="nav nav-pills nav-stacked collapse" id="sub-item-2">
			<li class="active" data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- <span class="glyphicon glyphicon-share-alt"></span> -->
					匹克
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- <span class="glyphicon glyphicon-share-alt"></span> -->
					李宁
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- 	<span class="glyphicon glyphicon-share-alt"></span> -->
					回力
				</a>
			</li>
		</ul>
	</li>
	<!-- sub-item4 -->

	<li class="kind" data-toggle="tab">
		<a class="child" data-toggle="collapse" href="#sub-item-3">
			<span class="glyphicon glyphicon-list"></span>
			衣服
			<span class="icon pull-right">
				<em class="glyphicon glyphicon-s glyphicon-plus"></em>
			</span>
		</a>
		<ul class="nav nav-pills nav-stacked collapse" id="sub-item-3">
			<li class="active" data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- 	<span class="glyphicon glyphicon-share-alt"></span> -->
					男人装
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- 	<span class="glyphicon glyphicon-share-alt"></span> -->
					女人装
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<!-- 	<span class="glyphicon glyphicon-share-alt"></span> -->
					儿童专场
				</a>
			</li>
		</ul>
	</li>

	<li data-toggle="tab">
		<a class="flushPage" href="#">食品</a>
	</li>
	<li data-toggle="tab">
		<a class="flushPage" href="#">其他</a>
	</li>
</ul>
<script src='<c:url value="/js/navSider.js"></c:url>'></script>