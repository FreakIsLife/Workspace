package com.zhku.jsj.base.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.zhku.jsj.admin.dao.AdminDao;
import com.zhku.jsj.admin.domain.Admin;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.domain.User;
import com.zhku.jsj.utils.jdbc.TxQueryRunner;

public class AdminDaoImpl implements AdminDao {
	private QueryRunner qr = new TxQueryRunner();

	public Admin findOneUser(Admin bean) throws SQLException {
		String sql = "select * from admin_info where adminId=? and adminPassword=?";
		return qr.query(sql, new BeanHandler<Admin>(Admin.class),
				bean.getAdminId(), bean.getAdminPassword());
	}

	@Override
	public boolean ValiusertId(String userId) throws SQLException {
		String sql = "select count(*) from user_info where userId=?";
		Long rs = qr.query(sql, new ScalarHandler<Long>(), userId);
		return rs.intValue() == 0;
	}

	public void AdminaddUser(User bean) throws SQLException {
		String sql = "insert into user_info value(?,?,?,?,?,?,?,?,?,?)";
		Object[] params = { bean.getUserId(), bean.getUserPassword(), null,
				bean.getUserNickname(), bean.getUserName(), bean.getUserSex(),
				bean.getUserBirth(), bean.getUserPhone(), bean.getUserMail(),
				null };
		qr.update(sql, params);
	}

	@Override
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) from user_info";
		long pagesize = (Long) qr.query(sql, new ScalarHandler<Long>());
		return (int) pagesize;
	}

	@Override
	public List<User> getPageDate(int startIndex, int pageSize)
			throws SQLException {
		String sql = "select * from user_info limit ?,?";
		return qr.query(sql, new BeanListHandler<User>(User.class), startIndex,
				pageSize);
	}

	@Override
	public void EditUser(User bean) throws SQLException {
		String sql = "update user_info set userPassword=?,userNickname=?,userName=?,userSex=?,"
				+ "userBirth=?,userPhone=?,userMail=? where userId=?";
		Object[] params = { bean.getUserPassword(), bean.getUserNickname(),
				bean.getUserName(), bean.getUserSex(), bean.getUserBirth(),
				bean.getUserPhone(), bean.getUserMail(), bean.getUserId() };
		qr.update(sql, params);

	}

	@Override
	public List<Shop> loadShop() throws SQLException {
		String sql = "SELECT * FROM shop_info";
		return qr.query(sql,new BeanListHandler<Shop>(Shop.class));
	}

	@Override
	public void EditShop(Shop shop) throws SQLException {
		String sql = "update shop_info set shopName=?,shopQQ=?where shopId=?";
		Object[] params = { shop.getShopName(), shop.getShopQQ(),shop.getShopId() };
		qr.update(sql, params);
	}

	@Override
	public void deleteShop(String shopId) throws SQLException {
		String sql="delete from shop_info where shopId=?";
		qr.update(sql, shopId);
	}

	@Override
	public void setuserIsShop(String shopId) throws SQLException {
		String sql = "update user_info set userIsShop=0 where userId=?";
		qr.update(sql, shopId);
	}

	@Override
	public List<Shop> getPageShopDate(int startIndex, int pageSize)
			throws SQLException {
		String sql = "select * from shop_info limit ?,?";
		return qr.query(sql, new BeanListHandler<Shop>(Shop.class), startIndex,
				pageSize);
	}

	@Override
	public int getTotalRowsShop() throws SQLException {
		String sql = "select count(*) from shop_info";
		long pagesize = (Long) qr.query(sql, new ScalarHandler<Long>());
		return (int) pagesize;
	}

	@Override
	public User SearchUserInfo(String id) throws SQLException {
		String sql = "select * from user_info where userId=?";
		return qr.query(sql, new BeanHandler<User>(User.class),id);
	}

	@Override
	public Shop SearchShopInfo(String id) throws SQLException {
		String sql = "select * from shop_info where shopId=?";
		return qr.query(sql, new BeanHandler<Shop>(Shop.class),id);
	}
	
	
}
