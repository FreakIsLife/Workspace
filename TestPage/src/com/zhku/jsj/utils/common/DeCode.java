package com.zhku.jsj.utils.common;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

public class DeCode {
	public static String decodeContent(String content) {
		try {
			return URLDecoder.decode(content, "utf-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
	}
}
