package com.zhku.jsj.admin.dao;

import java.sql.SQLException;
import java.util.List;

import com.zhku.jsj.admin.domain.Admin;
import com.zhku.jsj.shop.domain.Shop;
import com.zhku.jsj.user.domain.User;

public interface AdminDao {

	Admin findOneUser(Admin bean)throws SQLException;


	boolean ValiusertId(String userId)throws SQLException;


	void AdminaddUser(User bean)throws SQLException;


	int getTotalRows()throws SQLException;


	List<User> getPageDate(int startIndex, int pageSize) throws SQLException;


	void EditUser(User bean)throws SQLException;


	List<Shop> loadShop()throws SQLException;


	void EditShop(Shop shop)throws SQLException;


	void deleteShop(String shopId)throws SQLException;


	void setuserIsShop(String shopId)throws SQLException;


	List<Shop> getPageShopDate(int startIndex, int pageSize)throws SQLException;


	int getTotalRowsShop()throws SQLException;


	User SearchUserInfo(String id)throws SQLException;


	Shop SearchShopInfo(String id)throws SQLException;

}
