package com.mrbt.yeston.fingerprint.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/fingerprint")
public class FingerprintController {
	
	 private static final Logger LOGGER = LogManager.getLogger(FingerprintController.class);
	 
	 @RequestMapping("manager")
	 public String manager(HttpServletRequest request, HttpServletResponse response){
		 LOGGER.info("打开指纹管理页面");
		 return "/fingerprint/fingerprintManager";
	 }
	 
	 @RequestMapping("managertest")
	 public String managertest(HttpServletRequest request, HttpServletResponse response){
		 request.setAttribute("Cache-Control", "no-cache");
		 
		 LOGGER.info("打开指纹管理页面");
		 return "/fingerprint/fingerprintManager2";
	 }
	
}
