package com.zhku.jsj.admin.service;

import java.sql.SQLException;
import java.util.List;

import com.zhku.jsj.admin.dao.AdminDao;
import com.zhku.jsj.admin.domain.Admin;
import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.pager.PageBean;
import com.zhku.jsj.pager.PageShop;
import com.zhku.jsj.shop.dao.ShopDao;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.dao.UserDao;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.jdbc.JdbcUtils;

public class AdminService {
	private AdminDao ud = DaoFactory.getInstance().createDao(AdminDao.class);
	private ShopDao sd = DaoFactory.getInstance().createDao(ShopDao.class); 
	private UserDao us = DaoFactory.getInstance().createDao(UserDao.class);
	/**
	 * 管理员登录
	 * @param bean
	 * @return
	 * @throws SQLException
	 */
	public Admin login(Admin bean) throws SQLException {
		return ud.findOneUser(bean);
	}
    /**
     * 添加用户信息
     * @param bean
     */
	public void addUser(User bean) {
		try {
			ud.AdminaddUser(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}
     /**
      * 用户信息校验
      * @param userId
      * @return
      */
	public boolean ValiaddUserId(String userId) {
		try {
			return ud.ValiusertId(userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 查询当前页数的数据
	 * 
	 * @param pagenum
	 * @return
	 * @throws SQLException
	 */
	public PageBean PageQuery(String pagenum){
		try {
			int pageSize = 7; // 每页显示7条数据
			int pageNum = Integer.parseInt(pagenum); // 当前页数
			int totalRows = ud.getTotalRows(); // 计算总的行数
			int totalPages = (totalRows + pageSize - 1) / pageSize; // 总的页数
			int startIndex = (pageNum - 1) * pageSize; // 当前索引的页面
			List<User> user = ud.getPageDate(startIndex, pageSize); // 获得当前页面的数据

			PageBean pagebean = new PageBean();
			pagebean.setPageNum(pageNum);
			pagebean.setPageSize(pageSize);
			pagebean.setTotalPages(totalPages);
			pagebean.setTotalRows(totalRows);
			pagebean.setUser(user);
			return pagebean;
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
   /**
    * 修改用户信息
    * @param bean
    */
	public void EditUser(User bean) {
		try{
			ud.EditUser(bean);
		}catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
    /**
     * 添加商店信息
     * @param shop
     * @return
     */
	public Shop AddShop(Shop shop) {
		try {
			JdbcUtils.beginTransaction();
			us.setShop(shop.getShopId());
			Shop saveShop = sd.setShop(shop);
			JdbcUtils.commitTransaction();
			return saveShop;
		} catch (SQLException e) {
			try {
				JdbcUtils.rollbackTransaction();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}
    /**
     * 加载商店信息
     * @return
     */
	public List<Shop> loadShop(){
		try {
			return ud.loadShop();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
    /**
     * 修改商店信息
     * @param shop
     */
	public void EditShop(Shop shop) {
		try{
			ud.EditShop(shop);
		}catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
	}
    /**
     * 删除商店信息
     * @param shopId
     */
	public void deleteShop(String shopId) {
		try {
			JdbcUtils.beginTransaction();
			ud.setuserIsShop(shopId);
			ud.deleteShop(shopId);
			JdbcUtils.commitTransaction();
		} catch (SQLException e) {
			try {
				JdbcUtils.rollbackTransaction();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}
   /**
    * 商品分页加载信息
    * @param pagenum
    * @return
    */
	public PageShop PageQueryShop(String pagenum) {
		try {
			int pageSize = 7; // 每页显示7条数据
			int pageNum = Integer.parseInt(pagenum); // 当前页数
			int totalRows = ud.getTotalRowsShop(); // 计算总的行数
			int totalPages = (totalRows + pageSize - 1) / pageSize; // 总的页数
			int startIndex = (pageNum - 1) * pageSize; // 当前索引的页面
			List<Shop> shop = ud.getPageShopDate(startIndex, pageSize); // 获得当前页面的数据

			PageShop pageshop = new PageShop();
			pageshop.setPageNum(pageNum);
			pageshop.setPageSize(pageSize);
			pageshop.setTotalPages(totalPages);
			pageshop.setTotalRows(totalRows);
			pageshop.setShop(shop);
			return pageshop;
		}catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

	public User SearchUserInfo(String id) {
		try {
			return ud.SearchUserInfo(id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public Shop SearchShopInfo(String id) {
		try {
			return ud.SearchShopInfo(id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
