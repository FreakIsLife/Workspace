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
}
