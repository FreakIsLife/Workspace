<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
<style type="text/css">
.message-r li {
	float: left;
}
</style>
</head>

<body>
	<!--头 -->
	<header>
		<article>
			<div class="mt-logo">
				<!--顶部导航条 -->
				<div class="am-container header">
					<ul class="message-l">
						<li>
							<div class="topMessage">
								<div class="menu-hd">
									<a href="#" target="_top" class="h">亲，请登录</a> <a href="#"
										target="_top">免费注册</a>
								</div>
							</div>
						</li>
					</ul>
					<ul class="message-r">
						<li>
							<div class="topMessage home">
								<div class="menu-hd">
									<a href="#" target="_top" class="h">商城首页</a>
								</div>
							</div>
						</li>
						<li>
							<div class="topMessage my-shangcheng">
								<div class="menu-hd MyShangcheng">
									<a href="#" target="_top"><i
										class="am-icon-user am-icon-fw"></i>个人中心</a>
								</div>
							</div>
						</li>
						<li>
							<div class="topMessage mini-cart">
								<div class="menu-hd">
									<a id="mc-menu-hd" href="#" target="_top"><i
										class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong
										id="J_MiniCartNum" class="h">0</strong></a>
								</div>
							</div>
						</li>
						<li>
							<div class="topMessage favorite">
								<div class="menu-hd">
									<a href="#" target="_top"><i
										class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a>
								</div>
							</div>
						</li>
					</ul>
				</div>

				<!--悬浮搜索框-->

				<div class="nav white">
					<div class="logoBig">
						<ul>
							<li>
								<img
									src="${pageContext.request.contextPath }/images/logobig.png" />
							</li>
						</ul>
					</div>

					<div class="search-bar pr">

						<form>
							<input id="searchInput" name="index_none_header_sysc" type="text"
								placeholder="搜索" autocomplete="off">
							<input id="ai-topsearch" class="submit am-btn" value="搜索"
								type="submit">
						</form>
					</div>
				</div>

				<div class="clear"></div>
			</div>
		</article>
	</header>
	<jsp:include page="${showPage==null?'/user/information.jsp':showPage }"></jsp:include>
	<!--底部-->
	<div class="footer">
		<div class="footer-hd">
			<p>
				<a href="${pageContext.request.contextPath }/home.html">商城首页</a>
			</p>
		</div>
		<div class="footer-bd">
			<p>
				<em>© 2015-2025 Hengwang.com 版权所有. Collect from <a
					href="http://www.baidu.com/" target="_blank">百度一下，你就知道</a></em>
			</p>
		</div>
	</div>
</body>
</html>
