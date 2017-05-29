package com.zhku.jsj.product.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhku.jsj.base.servlet.BaseServlet;
import com.zhku.jsj.pager.Page;
import com.zhku.jsj.product.domain.Product;
import com.zhku.jsj.product.service.ProductService;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.common.CommonUtil;
import com.zhku.jsj.utils.upload.FileItemUtil;

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
	 * 删除商品
	 * 
	 * @1. 要删除的商品Id字符串存放在delData变量中
	 * @2. 如果长度大于1则是批量删除
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String delete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String delData = request.getParameter("delData");
		System.out.println(delData);
		ps.deleteProduct(delData);
		return null;
	}

	/**
	 * 修改商品信息
	 * 
	 * @1. 将获取到的数据封装bean
	 * @2. 设置店铺id
	 * @3. 判断是否有修改图片，设置图片路径
	 * @4. 交与业务层处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String edit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Product bean = CommonUtil.toBean(request.getParameterMap(),
				Product.class);
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		bean.setShopId(loginUser.getUserId());
		String filePath = FileItemUtil.doFileUpload(request, "productImg", 60,
				60);
		String oldImg = request.getParameter("productOldImg");
		if ("".equals(filePath)) {
			// 没有编辑商品图片
			bean.setProductImg(oldImg);
			;
		} else {
			// 用户有旧头像和上传头像而且两个路径不一样
			bean.setProductImg(filePath);
			FileItemUtil.deleteOldImg(request, oldImg);
		}
		ps.editProduct(bean);
		return null;
	}

	/**
	 * 添加商品
	 * 
	 * @1. 对获取的商品信息封装bean，并上传图片
	 * @2. 生成uuid作为商品的Id
	 * @3. 默认初始销量为0，默认商家Id为session中用户Id
	 * @4. 交与业务层处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		Product bean = CommonUtil.toBean(request.getParameterMap(),
				Product.class);
		String filePath = FileItemUtil.doFileUpload(request, "productImg", 60,
				60);
		bean.setProductImg(filePath);
		bean.setProductId(CommonUtil.getUUID());
		bean.setProductSale(0);
		bean.setShopId(loginUser.getUserId());
		ps.addProduct(bean);
		return null;
	}

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

	/**
	 * 获取搜索的商品
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getSearchProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Page pageBean = CommonUtil
				.toBean(request.getParameterMap(), Page.class);
		String productName = request.getParameter("productName");
		List<Product> productList = ps.searchProduct(pageBean, productName);
		String productListJson = ps.getProductListJson(productList);
		// 需要返回的数据有总记录数和行数据
		String json = "{\"total\":" + pageBean.getTotalRow() + ",\"rows\":"
				+ productListJson + "}";
		return json;
	}

	/**
	 * 获取商品的List列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
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
		request.getRequestDispatcher("/page/bookList.jsp").forward(request,
				response);
		return null;
	}

	/**
	 * 获取商品的列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String getProductIntro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String productId = request.getParameter("productId");
		Product bean = ps.findById(productId);
		request.setAttribute("product", bean);
		request.getRequestDispatcher("/page/bookItro.jsp").forward(request,
				response);
		return null;
	}
}
