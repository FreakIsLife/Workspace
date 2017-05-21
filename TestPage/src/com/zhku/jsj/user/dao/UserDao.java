package com.zhku.jsj.user.dao;

import java.sql.SQLException;

import com.zhku.jsj.user.domain.User;

public interface UserDao {

	/**
	 * 通过用户名和密码来查询一个用户
	 * 
	 * @param bean
	 * @return
	 * @throws SQLException
	 */
	User findOneUser(User bean) throws SQLException;

	/**
	 * 添加一个用户
	 * 
	 * @param bean
	 * @throws SQLException
	 */
	void addUser(User bean) throws SQLException;

	/**
	 * 检验注册用户Id是否合法
	 * 
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	boolean findOneUserById(String userId) throws SQLException;

	/**
	 * 保存用户信息
	 * 
	 * @param bean
	 */
	void updateUserInfo(User bean) throws SQLException;

	/**
	 * 设置用户状态是开店
	 * @throws SQLException
	 */
	void setShop(String userId) throws SQLException;

}
