<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<title>店铺信息</title>
<form action="${ctx }/shopServlet?method=saveInfo" class="form-horizontal"
	id="shopInfoForm">
	<fieldset>
		<legend>个人信息表</legend>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="shopId" class="col-lg-2 control-label">店铺Id</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入店铺Id" id="shopId"
						name="shopId" type="text" readonly="readonly"
						value="${shop.shopId }">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="shopName" class="col-lg-2 control-label">店铺名</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入昵称" id="shopName"
						name="shopName" type="text" value="${shop.shopName }">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="shopQQ" class="col-lg-2 control-label">联系方式</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入联系QQ" id="shopQQ"
						name="shopQQ" type="text" value="${shop.shopQQ }">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="shopStart" class="col-lg-2 control-label">开店日期</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" type="text" readonly="readonly"
						id="shopStart" name="shopStart"
						value='<fmt:formatDate value="${shop.shopStart }" type="both" pattern="yyyy-mm-dd"/>' />
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Button -->
			<div class="col-lg-4 col-lg-offset-4">
				<button class="btn btn-info usualSubmitBtn">保存修改</button>
			</div>
		</div>
	</fieldset>
</form>