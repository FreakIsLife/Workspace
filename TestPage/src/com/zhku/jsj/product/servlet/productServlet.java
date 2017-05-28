package com.zhku.jsj.product.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.domain.Product;
import com.zhku.jsj.product.service.ProductService;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.common.CommonUtil;

/**
 * 商品表相关servlet
 * 
 * @author Administrator
 *
 */
@WebServlet("/productServlet")
@MultipartConfig
public class productServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;
	private ProductService ps = new ProductService();

	/**
	 * 获得店铺商品
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getShopProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Page pageBean = CommonUtil
				.toBean(request.getParameterMap(), Page.class);
		String productName = request.getParameter("productName");
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		List<Product> productList = ps.findProductByName(pageBean, productName,
				loginUser.getUserId());
		String productListJson = ps.getProductListJson(productList);
		// 需要返回的数据有总记录数和行数据
		String json = "{\"total\":" + pageBean.getTotalRow() + ",\"rows\":"
				+ productListJson + "}";
		return json;
	}

	/* 怎么样子获得javabean的？如何封装数据的？ */
	public String getProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Page pageBean = CommonUtil
				.toBean(request.getParameterMap(), Page.class);

		// 1.默认访问第一页
		pageBean.setPageNum(1);
		String _pageNum = request.getParameter("pageNum");
		if (_pageNum != null) {
			pageBean.setPageNum(Integer.parseInt(_pageNum));
		}
		pageBean.setLimit(12);
		pageBean.setOffset((pageBean.getPageNum() - 1) * pageBean.getLimit());
		ps.getProduct(pageBean);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("/page/productList.jsp").forward(request,
				response);
		return null;
	}
	
	public String getProductIntro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String pId = request.getParameter("productId");
		String proName =request.getParameter("productName");
		String pName = new String(proName.getBytes("utf-8"),"ISO8859-1");
		
		String pSale =request.getParameter("productSale");
		String pPrice =request.getParameter("productPrice");
		String pLeft =request.getParameter("productLeft");
		
		request.setAttribute("productId", pId);
		request.setAttribute("productName", pName);
		request.setAttribute("productSale", pSale);
		request.setAttribute("productPrice", pPrice);
		request.setAttribute("productLeft", pLeft);
		System.out.println(pId+"nihao !!");
		
		
		
		request.getRequestDispatcher("/page/productIntro.jsp").forward(request,
				response);
		return null;
	}
	
}
