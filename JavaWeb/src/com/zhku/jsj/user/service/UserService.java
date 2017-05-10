package com.zhku.jsj.user.service;

import java.sql.SQLException;

import com.zhku.jsj.base.dao.factory.DaoFactory;
import com.zhku.jsj.user.dao.UserDao;
import com.zhku.jsj.user.domain.User;

public class UserService {
	private UserDao ud = DaoFactory.getInstance().createDao(UserDao.class);

	public User login(User bean){
		try {
			return ud.findOneUser(bean);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	
}
