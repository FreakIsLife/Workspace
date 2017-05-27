package com.zhku.jsj.utils.common;

public class TranPicToSmall {
	public static String getSmallPic(String pic) {
		String[] array = pic.split("\\.");
		int length = array.length;
		array[length - 1] = "_small." + array[length - 1];
		String smallPic = "";
		for (String str : array) {
			smallPic += str;
		}
		return smallPic;
	}
}
