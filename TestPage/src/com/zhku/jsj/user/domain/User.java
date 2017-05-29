package com.zhku.jsj.user.domain;

import java.util.Date;

import com.zhku.jsj.shop.domain.Shop;

public class User {
	// 对应数据库中的user_info表
	private String userId; // 主键
	private String userPassword; // 密码
	private String userImg;		//用户头像
	private String userNickname; // 用户昵称
	private String userName; // 用户名
	private int userSex; // 性别
	private Date userBirth; // 生日
	private String userPhone; // 联系方式
	private String userMail; // 电子邮件
	private int userIsShop;		//用户是否开店
	private Shop userShop;		//用户的店铺

	public String getUserId() {
		return userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public String getUserImg() {
		return userImg;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public String getUserName() {
		return userName;
	}

	public int getUserSex() {
		return userSex;
	}

	public Date getUserBirth() {
		return userBirth;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public String getUserMail() {
		return userMail;
	}

	public int getUserIsShop() {
		return userIsShop;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setUserSex(int userSex) {
		this.userSex = userSex;
	}

	public void setUserBirth(Date userBirth) {
		this.userBirth = userBirth;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}

	public void setUserIsShop(int userIsShop) {
		this.userIsShop = userIsShop;
	}

	public Shop getUserShop() {
		return userShop;
	}

	public void setUserShop(Shop userShop) {
		this.userShop = userShop;
	}

}
