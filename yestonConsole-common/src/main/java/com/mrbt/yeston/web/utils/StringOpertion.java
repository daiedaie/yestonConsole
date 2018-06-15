package com.mrbt.yeston.web.utils;


import org.apache.commons.lang.StringUtils;

public class StringOpertion {
	
	/**
	 * 隐藏银行卡号
	 * @param bankCard
	 * @return
	 */
	public static String hideBankCard(String bankCard){
		int len = bankCard.length();
		bankCard = bankCard.substring(0, 6) + "********" + bankCard.substring(len -4, len);
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
			idenCard = idenCard.substring(0, 3) + "***********" + idenCard.substring(len -4, len);
		}			
		return idenCard;
	}
	/**
	 * 隐藏姓名
	 * @param name
	 * @return
	 */
	public static String hideRealName(String name){
		if(!StringUtils.isBlank(name)){
			name=name.trim();
			//只保留姓
			name=name.substring(0,1)+"*";
		}			
		return name;
	}
	
	/**
	 * 隐藏姓名
	 * @param name
	 * @return
	 */
	public static String hideMoblieNum(String moblieNum){
		if(!StringUtils.isBlank(moblieNum)){
			moblieNum=moblieNum.trim();
			//隐藏中间四位 186 0071 6314
			int len = moblieNum.length();
			moblieNum = moblieNum.substring(0, 3) + "****" + moblieNum.substring(len -4, len);
		}			
		return moblieNum;
	}
	
	public static Object[] dealCertNo(String certNo) throws Exception{
		//130602199207161545 
		int length=certNo.length();
		String birthday=certNo.substring(6, 14);
		String sex="";
		if(length==18){
			sex=certNo.substring(16,17);
		}else{
			sex=certNo.substring(14,15);
		}
		Object[] res=new Object[]{birthday,Integer.parseInt(sex)%2};
		return res;
	}
	
	public static void main(String[] args) {
		try {
			System.out.println(dealCertNo("130602199207161")[0]);
			System.out.println(dealCertNo("130602199207161")[1]);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
