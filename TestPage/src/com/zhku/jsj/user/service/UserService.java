package com.zhku.jsj.user.service;

import java.sql.SQLException;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.shop.dao.ShopDao;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.dao.UserDao;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.jdbc.JdbcUtils;

/**
 * 用户业务层逻辑
 * 
 * @author Administrator
 *
 */
public class UserService {
	private UserDao ud = DaoFactory.getInstance().createDao(UserDao.class);
	private ShopDao sd = DaoFactory.getInstance().createDao(ShopDao.class);

	/**
	 * 调用findOneUser查看数据是否存在该用户 如果存在则返回该用户的UserBean，不存在就返回null
	 * 
	 * @param bean
	 * @return
	 */
	public User login(User bean) {
		try {
			return ud.findOneUser(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 用addUser添加UserBean到数据库中
	 * 
	 * @param bean
	 */
	public void regist(User bean) {
		try {
			ud.addUser(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 用findOneUserById查找是否存在相同Id
	 * 
	 * @param userId
	 * @return
	 */
	public boolean validateId(String userId) {
		try {
			return ud.findOneUserById(userId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 用updateUserInfo将数据保存在数据库
	 * 
	 * @param bean
	 */
	public void saveInfo(User bean) {
		try {
			ud.updateUserInfo(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 开启店铺 由于操作多个表，所以开启事务
	 * 
	 * @param bean
	 */
	public Shop setShop(Shop bean) {
		try {
			JdbcUtils.beginTransaction();
			ud.setShop(bean.getShopId());
			Shop saveShop = sd.setShop(bean);
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
	 * 修改密码
	 * 
	 * @param userId
	 * @param newPassword
	 */
	public void changePassword(String userId, String newPassword) {
		try {
			ud.updatePassword(userId, newPassword);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
