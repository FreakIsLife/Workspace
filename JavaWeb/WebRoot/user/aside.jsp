<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
	$(".person li").click(function(){
		this.addClass('active')
});
</script>
<aside class="menu">
	<ul>
		<li class="person active">
			<a href="${pageContext.request.contextPath }/user/main.jsp"><i class="am-icon-user"></i>个人中心</a>
		</li>
		<li class="person">
			<p>
				<i class="am-icon-newspaper-o"></i>个人资料
			</p>
			<ul>
				<li>
					<a href="${pageContext.request.contextPath }/user/information.jsp">个人信息</a>
				</li>
				<li>
					<a href="safety.html">安全设置</a>
				</li>
				<li>
					<a href="address.html">地址管理</a>
				</li>
			</ul>
		</li>
		<li class="person">
			<p>
				<i class="am-icon-balance-scale"></i>我的交易
			</p>
			<ul>
				<li>
					<a href="order.html">订单管理</a>
				</li>
			</ul>
		</li>
		<li class="person">
			<p>
				<i class="am-icon-dollar"></i>我的资产
			</p>
			<ul>
				<li>
					<a href="walletlist.html">账户余额</a>
				</li>
				<li>
					<a href="bill.html">账单明细</a>
				</li>
			</ul>
		</li>

		<li class="person">
			<p>
				<i class="am-icon-tags"></i>我的收藏
			</p>
			<ul>
				<li>
					<a href="collection.html">收藏</a>
				</li>
			</ul>
		</li>

		<li class="person">
			<p>
				<i class="am-icon-qq"></i>在线客服
			</p>
			<ul>
				<li>
					<a href="consultation.html">商品咨询</a>
				</li>
				<li>
					<a href="suggest.html">意见反馈</a>
				</li>

				<li>
					<a href="news.html">我的消息</a>
				</li>
			</ul>
		</li>
	</ul>
</aside>