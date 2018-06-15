package com.mrbt.yeston.admin.commons.utils;

public class StringOpertion {
	
	/**
	 * 隐藏银行卡号
	 * @param bankCard
	 * @return
	 */
	public static String hideBankCard(String bankCard){
		if(bankCard != null && !bankCard.equals("")){
			int len = bankCard.length();
			bankCard = bankCard.substring(0, 6) + "********" + bankCard.substring(len -4, len);
		}
		return bankCard;
	}
	
	/**
	 * 隐藏身份证号
	 * @param idenCard
	 * @return
	 */
	public static String hideIdenCard(String idenCard){
		if(idenCard != null && !idenCard.equals("")){
			int len = idenCard.length();
			idenCard = idenCard.substring(0, len -8) + "****" + idenCard.substring(len -4, len);
		}			
		return idenCard;
	}
	/**
	 * 隐藏手机号
	 * @param telephone
	 * @return
	 */
	public static String hideTelephone(String telephone){
		if(telephone != null && !telephone.equals("")){
			int len = telephone.length();
			telephone = telephone.substring(0, 3) + "****" + telephone.substring(len -4, len);
		}			
		return telephone;
	}
	/**
	 * 隐藏真实姓名
	 * @param name
	 * @return
	 */
	public static String hideName(String name){
		if(name != null && !name.equals("")){
			name = name.substring(0, 1) + "**";
		}			
		return name;
	}
	
	public static void main(String[] args) {
		System.out.println(hideBankCard("6225880140356867"));
		System.out.println(hideIdenCard("210181198412136131"));
		System.out.println(hideTelephone("18958585858"));
		System.out.println(hideName("张三"));
	}
}
