package com.zhku.jsj.base.dao.factory;

import java.util.ResourceBundle;

public class DaoFactory {

	private DaoFactory() {
	};

	private static DaoFactory instance = new DaoFactory();

	public static DaoFactory getInstance() {
		return instance;
	}

	// 返回dao 的实例
	@SuppressWarnings("unchecked")
	public <T> T createDao(Class<T> clazz) {

		// 获得 simpleName ,然后 去读 properties 配置文件
		String simpleName = clazz.getSimpleName();

		// 读dao.properties
		String className = ResourceBundle.getBundle("dao")
				.getString(simpleName);

		try {
			return (T) Class.forName(className).newInstance();
		} catch (Exception e) {

			return null;
		}

	}
}
