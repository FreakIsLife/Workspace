package com.zhku.jsj.user.dao;

import java.sql.SQLException;

import com.zhku.jsj.user.domain.User;

public interface UserDao {

	User findOneUser(User bean) throws SQLException;
	
}
