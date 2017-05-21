<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href='<c:url value="/css/navSide.css"></c:url>' rel="stylesheet">
<ul class="nav nav-pills nav-stacked">
	<li class="active kind" data-toggle="tab">
		<a class="child" data-toggle="collapse" href="#sub-item-1">
			<span class="glyphicon glyphicon-list"></span>
			种类1
			<span class="icon pull-right">
				<em class="glyphicon glyphicon-s glyphicon-plus"></em>
			</span>
		</a>
		<ul class="nav nav-pills nav-stacked collapse" id="sub-item-1">
			<li class="active" data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					Sub Item 1
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					Sub Item 2
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					Sub Item 3
				</a>
			</li>
		</ul>
	</li>
	<li class="kind" data-toggle="tab">
		<a class="child" data-toggle="collapse" href="#sub-item-2">
			<span class="glyphicon glyphicon-list"></span>
			种类2
			<span class="icon pull-right">
				<em class="glyphicon glyphicon-s glyphicon-plus"></em>
			</span>
		</a>
		<ul class="nav nav-pills nav-stacked collapse" id="sub-item-2">
			<li class="active" data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					Sub Item 1
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					Sub Item 2
				</a>
			</li>
			<li data-toggle="tab">
				<a class="flushPage" href="#">
					<span class="glyphicon glyphicon-share-alt"></span>
					Sub Item 3
				</a>
			</li>
		</ul>
	</li>
	<li data-toggle="tab">
		<a class="flushPage" href="#">种类3</a>
	</li>
	<li data-toggle="tab">
		<a class="flushPage" href="#">种类4</a>
	</li>
</ul>
<script src='<c:url value="/js/navSider.js"></c:url>'></script>