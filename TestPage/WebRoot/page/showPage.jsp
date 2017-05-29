<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>商品</title>

<<<<<<< HEAD
<script type="text/javascript">
	window.onload = function() {
		flag = 0;
		obj1 = document.getElementById("slider_rq");
		obj2 = document.getElementsByName("rq_li");
		obj2[0].style.backgroundColor = "#666666";
		//默认被选中颜色 
		time = setInterval("turn();", 4500);
		obj1.onmouseover = function() {
			clearInterval(time);
		}
		obj1.onmouseout = function() {
			time = setInterval("turn();", 6000);
		}

		for (var num = 0; num < obj2.length; num++) {
			obj2[num].onmouseover = function() {
				turn(this.innerHTML);
				clearInterval(time);
			}
			obj2[num].onmouseout = function() {
				time = setInterval("turn();", 6000);
			}
		}
		//延迟加载图片，演示的时候，使用本地图片
		//上线后请改为二级域名提供的图片地址 
		document.getElementById("second").src = "../images/2.jpg";
		//使用图片宽660，高550 
		document.getElementById("third").src = "../images/3.jpg";
		document.getElementById("four").src = "../images/4.jpg";
	}
	function turn(value) {
		if (value != null) {
			flag = value - 2;
		}
		if (flag < obj2.length - 1)
			flag++;
		else
			flag = 0;
		obj1.style.top = flag * (-320) + "px";
		for (var j = 0; j < obj2.length; j++) {
			obj2[j].style.backgroundColor = "#ffffff";
		}
		obj2[flag].style.backgroundColor = "#666666";
	}

/* 对轮播进行隐藏 */
/* 	setTimeout(function() {
		$('#wrap_rq').fadeOut("slow")
	}, 10000);
 */
	
</script>
<style type="text/css">
#wrap_rq {
	height: 320px;
	width: 760px;
	overflow: hidden;
	position: relative;
	overflow: hidden;
}

#wrap_rq ul {
	list-style: none;
	position: absolute;
	top: 260px;
	left: 450px;
}

#wrap_rq li {
	margin-left: 2px;
	opacity: .3;
	filter: alpha(opacity = 30);
	text-align: center;
	line-height: 30px;
	font-size: 20px;
	height: 30px;
	width: 30px;
	background-color: #fff;
	float: left;
	border-radius: 3px;
	cursor: pointer;
}

#slider_rq {
	position: absolute;
	top: 0px;
	left: 0px;
}

#slider_rq img {
	float: left;
	border: none;
}

</style>
<!-- 这是轮播的效果 -->
 
 <div id="wrap_rq"> 
  <div id="slider_rq"> 
	   <a target="_blank" href="#"><img src="../images/1.jpg" /></a> 
	   <a target="_blank" href="#"><img id="second" /></a> 
	   <a target="_blank" href="#"><img id="third" /></a> 
	   <a target="_blank" href="#"><img id="four" /></a> 
  </div> 
	  <ul> 
	   <li name="rq_li">1</li> 
	   <li name="rq_li">2</li> 
	   <li name="rq_li">3</li> 
	   <li name="rq_li">4</li> 
	  </ul> 
 </div>
   
    
    
    
=======
<!-- 这是轮播的效果 -->
<div id="carousel-example-generic" class="carousel slide"
	data-ride="carousel" style="width:760px;">
	<!-- Indicators -->
	<ol class="carousel-indicators">
		<li data-target="#carousel-example-generic" data-slide-to="0"
			class="active"></li>
		<li data-target="#carousel-example-generic" data-slide-to="1"></li>
		<li data-target="#carousel-example-generic" data-slide-to="2"></li>
		<li data-target="#carousel-example-generic" data-slide-to="3"></li>
	</ol>

	<!-- Wrapper for slides -->
	<div class="carousel-inner" role="listbox">
		<div class="item active">
			<img src="../images/1.jpg" alt="...">
			<div class="carousel-caption">...</div>
		</div>
		<div class="item">
			<img src="../images/2.jpg" alt="...">
			<div class="carousel-caption">...</div>
		</div>
		<div class="item">
			<img src="../images/3.jpg" alt="...">
			<div class="carousel-caption">...</div>
		</div>
		<div class="item">
			<img src="../images/4.jpg" alt="...">
			<div class="carousel-caption">...</div>
		</div>
	</div>

	<!-- Controls -->
	<a class="left carousel-control" href="#carousel-example-generic"
		role="button" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>
	<a class="right carousel-control" href="#carousel-example-generic"
		role="button" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>
</div>
>>>>>>> refs/remotes/origin/lcr
