package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.zhku.jsj.user.dao.UserDao;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.jdbc.TxQueryRunner;

public class UserDaoImpl implements UserDao {
	private QueryRunner qr = new TxQueryRunner();
	@Override
	public User findOneUser(User bean) throws SQLException {
		String sql = "select * from user_info where userId=? and userPassword=?";
		return qr.query(sql, new BeanHandler<User>(User.class), bean.getUserId(),bean.getUserPassword());
	}

}
