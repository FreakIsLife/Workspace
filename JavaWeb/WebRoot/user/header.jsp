<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--头 -->
<style type="text/css">
.message-r li {
	float: left;
}
</style>
<header>
	<article>
		<div class="mt-logo">
			<!--顶部导航条 -->
			<div class="am-container header">
				<ul class="message-l">
					<li>
						<div class="topMessage">
							<div class="menu-hd">
								<c:if test="${ not empty loginUser }">
										${loginUser.userNickname } 欢迎回来！
									</c:if>
							</div>
						</div>
					</li>
				</ul>
				<ul class="message-r">
					<li>
						<div class="topMessage home">
							<div class="menu-hd">
								<a href="${pageContext.request.contextPath }/home.jsp"
									target="_top" class="h">商城首页</a>
							</div>
						</div>
					</li>
					<li>
						<div class="topMessage my-shangcheng">
							<div class="menu-hd MyShangcheng">
								<a href="${pageContext.request.contextPath }/user/main.jsp"
									target="_top">
									<i class="am-icon-user am-icon-fw"></i>个人中心
								</a>
							</div>
						</div>
					</li>
					<li>
						<div class="topMessage mini-cart">
							<div class="menu-hd">
								<a id="mc-menu-hd" href="#" target="_top">
									<i class="am-icon-shopping-cart  am-icon-fw"></i>
									<span>购物车</span>
									<strong id="J_MiniCartNum" class="h">0</strong>
								</a>
							</div>
						</div>
					</li>
					<li>
						<div class="topMessage favorite">
							<div class="menu-hd">
								<a href="#" target="_top">
									<i class="am-icon-heart am-icon-fw"></i>
									<span>收藏夹</span>
								</a>
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
							<img src="${pageContext.request.contextPath }/images/logobig.png" />
						</li>
					</ul>
				</div>

				<div class="search-bar pr">

					<form action="#" method="post">
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
