<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<title>个人信息</title>
<form action="${ctx }/userServlet?method=setShop"
	class="form-horizontal" id="setShopForm">
	<fieldset>
		<legend>用户开店</legend>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="shopName" class="col-lg-2 control-label">店铺名</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入店铺名" id="shopName"
						name="shopName" type="text">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="shopQQ" class="col-lg-2 control-label">联系QQ</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入店铺联系QQ" id="shopQQ"
						name="shopQQ" type="text">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Button -->
			<div class="col-lg-4 col-lg-offset-4">
				<button class="btn btn-info usualSubmitBtn">确认开店</button>
			</div>
		</div>
	</fieldset>
</form>