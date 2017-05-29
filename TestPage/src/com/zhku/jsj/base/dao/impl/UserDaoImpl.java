package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.zhku.jsj.user.dao.UserDao;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.jdbc.TxQueryRunner;

public class UserDaoImpl implements UserDao {
	private QueryRunner qr = new TxQueryRunner();

	@Override
	public User findOneUser(User bean) throws SQLException {
		String sql = "select * from user_info where userId=? and userPassword=?";
		return qr.query(sql, new BeanHandler<User>(User.class),
				bean.getUserId(), bean.getUserPassword());
	}

	@Override
	public void addUser(User bean) throws SQLException {
		String sql = "insert into user_info value(?,?,?,?,?,?,?,?,?,?)";
		Object[] params = { bean.getUserId(), bean.getUserPassword(),
				bean.getUserImg(), bean.getUserNickname(), bean.getUserName(),
				bean.getUserSex(), bean.getUserBirth(), bean.getUserPhone(),
				bean.getUserMail(), null };
		qr.update(sql, params);
	}

	@Override
	public boolean findOneUserById(String userId) throws SQLException {
		String sql = "select count(*) from user_info where userId=?";
		Long rs = qr.query(sql, new ScalarHandler<Long>(), userId);
		return rs.intValue() == 0;
	}

	@Override
	public void updateUserInfo(User bean) throws SQLException {
		String sql = "update user_info set userPassword=?,userImg=?,userNickname=?,userName=?,userSex=?,userBirth=?,userPhone=?,userMail=? where userId=?";
		Object[] params = { bean.getUserPassword(), bean.getUserImg(),
				bean.getUserNickname(), bean.getUserName(), bean.getUserSex(),
				bean.getUserBirth(), bean.getUserPhone(), bean.getUserMail(),
				bean.getUserId() };
		qr.update(sql, params);
	}

	@Override
	public void setShop(String userId) throws SQLException {
		String sql = "update user_info set userIsShop=1 where userId=?";
		qr.update(sql, userId);
	}

	public List<User> load() throws SQLException{
		String sql = "SELECT * FROM user_info";
		return qr.query(sql,new BeanListHandler<User>(User.class));
	}
	
	public void deleteUser(String userId)throws SQLException{
		String sql="delete from user_info where userId=?";
		qr.update(sql, userId);
	}
	@Override
	public void updatePassword(String userId, String password)
			throws SQLException {
		String sql = "update user_info set userPassword=? where userId=?";
		Object[] params = { password, userId };
		qr.update(sql, params);
	}

}
