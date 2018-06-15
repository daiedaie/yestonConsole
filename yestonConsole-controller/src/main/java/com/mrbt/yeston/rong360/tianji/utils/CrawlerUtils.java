package com.mrbt.yeston.rong360.tianji.utils;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;

/**
 * 抓取工具类
 * @author 融360-天机
 *
 */
public class CrawlerUtils {
    
    
    public static Set<Integer> refreshType = new HashSet<Integer>();
        
    static{
        refreshType.add(8);//图片验证码
        refreshType.add(9);//短信验证码
    }
    
    public static final String getLoginInfo = "getLoginInfo";
    /**
     * 获取图片验证码字符串
     */
    public static final String getPicCode = "getPicCode";
    /**
     * 获取短信验证码字符串
     */
    public static final String getMessageCode = "getMessageCode";
    /**
     * 登录字符串
     */
    public static final String login = "login";
    
    /**
     * 按key进行正序排列,之间以&相连
     * @param params 参数键值对
     * @return String 返回拼接好的字符串
     */
    public static String getSortParams(Map<String, String> params) {
        SortedMap<String, String> map = new TreeMap<String, String>();
        for (String key: params.keySet()) {
            map.put(key, params.get(key));
        }
        
        Set<String> keySet = map.keySet();
        Iterator<String> iter = keySet.iterator();
        String str = "";
        while (iter.hasNext()) {
            String key = iter.next();
            String value = map.get(key);
            str += key + "=" + value + "&";
        }
        if(str.length()>0){
            str = str.substring(0, str.length()-1);
        }
        return str;
    }
    
    /**
     * 通过method获得responseKey
     * @param method 方法
     * @return String 转换后的拼接字符串
     */
    public static String getResponseKeyByMethod(String method){
        String responseKey = "";
        if(StringUtils.isNotBlank(method)){
            String[] splits = method.split("\\.");
            for(String item:splits){
                responseKey += item+"_";
            }
            responseKey += "response";
        }
        return responseKey;
    }
}
