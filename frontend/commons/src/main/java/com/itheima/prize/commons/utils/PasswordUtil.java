package com.itheima.prize.commons.utils;

import java.math.BigInteger;
import java.security.MessageDigest;

/**
 * 密码工具类
 */
public class PasswordUtil {
	

	private String md5(String inputStr) {
		BigInteger bigInteger = null;
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] inputData = inputStr.getBytes();
			md.update(inputData);
			bigInteger = new BigInteger(md.digest());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bigInteger.toString(16);
	}

	/**
	 * 密码加密
	 */
	public static String encodePassword(String password) {
		return new PasswordUtil().md5(password);
	}
	
	public static void main(String[] args) {
		System.out.println(encodePassword("123456"));
	}

}
