<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

   <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="css/jqzoom.css" type="text/css">
<script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>
<script src="js/jqzoom.pack.1.0.1.js" type="text/javascript"></script>


<script type="text/javascript">
var orderNum=1;

$(function() {
	var options =
	{
		zoomWidth: 250, //放大镜的宽度
		zoomHeight: 250,//放大镜的高度
		zoomType:'standard'
	};
	$(".jqzoom").jqzoom(options);
});

$(function(){
	
	$("#deduce").click(function(){
	 	orderNum--;
	})
	$("#add").click(function(){
		orderNum--;
	})
})

</script>
</head>
<style type="text/css">
#allDiv{
	margin: 0 auto;
}
#content1{
	width:600px;
	position:absolute;
}

#pd_detail{
	margin-left:600px;

}
</style>


<body>
<!-- 代码 开始 -->
<% 
	request.setCharacterEncoding("utf-8");
%>


<div id="allDiv">
	<div id="content1" style="width:600px;">
		<a href="images/big.jpg" class="jqzoom" style="" title="图片标题"> 
			<img src="images/small.jpg"  title="图片标题" style="border: 1px solid #666;"> 
		</a> 
	</div>

<div id="pd_detail">
	<!--名称-->
	<h1 style="font-weight: bolder; color: black;">名字：${productName}</h1>
	<h3>商品ID：${productId }</h3>
		<!--价格-->
		<div class="tb-detail-price">
				<b class="sys_item_mktprice">价格：<em>¥</em>${productPrice}</b>									
		</div>
	<!--地址-->
		配送至
		<div class="">
			<div >
				<select >
					<option value="a">广东省</option>
					<option value="b">湖北省</option>
				</select>
				<select >
					<option value="c">广州</option>
					<option value="d">深圳</option>
				</select>
				<select >
					<option value="e">天河区</option>
					<option value="f">海珠区</option>
				</select>
				  &nbsp;&nbsp;&nbsp;快递：<b style="color:olive;">包邮</b>
			</div>
		</div>
		
		<div>
			<span>销量：${productSale}</span>
		</div>
		
		<div>
			数量
			<input id="deduce" name="deNum" type="button" value="-" />
			<input name="orderNum" type="text" value="${orderNum}"  style="width:30px;" />
			<input id="add" name="addNum" type="button" value="+" />
			<span >库存:${productLeft}件</span>
		</div>
		
		<div>
		<div>
			<a href="./home.jsp"><span >首页</span></a>
			<a><span>收藏</span></a>
			
			<p>
				<a href="#" class="btn btn-warning" role="button">
					立即购买
					<span class="glyphicon glyphicon-shopping-cart"></span>
				</a>
			&nbsp;&nbsp;&nbsp;
				<a href="#" class="btn btn-primary" role="button">
					加入购物车
					<span class="glyphicon glyphicon-shopping-cart"></span>
				</a>
			</p>	
		</div>

</div>
</div>
</div>
</body>
    