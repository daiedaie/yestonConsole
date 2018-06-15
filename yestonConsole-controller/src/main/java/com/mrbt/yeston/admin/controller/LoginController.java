package com.mrbt.yeston.admin.controller;

import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.commons.utils.DigestUtils;
import com.mrbt.yeston.admin.commons.utils.StringUtils;
import com.mrbt.yeston.admin.model.User;
import com.mrbt.yeston.admin.service.UserService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @description：登录退出
 * @author：ruochen.yu
 * @date：2016/10/1 14:51  
 */
@Controller
public class LoginController extends BaseController {
    private static final Logger LOGGER = LogManager.getLogger(LoginController.class);
    
    
    @Autowired
    private UserService userService;
    
    /**
     * 首页
     *
     * @return
     */
    @RequestMapping(value = "/")
    public String index() {
        return "redirect:/index";
    }

    /**
     * 首页
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/index")
    public String index(Model model) {
        return "index";
    }

    /**
     * GET 登录
     * @return {String}
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        LOGGER.info("GET请求登录");
        if (SecurityUtils.getSubject().isAuthenticated()) {
            return "redirect:/index";
        }
        return "login";
    }
    
    /**
     * GET 登录2
     * @return {String}
     */
    @RequestMapping(value = "/login2", method = RequestMethod.GET)
    public String login2() {
        LOGGER.info("GET请求登录");
        if (SecurityUtils.getSubject().isAuthenticated()) {
            return "redirect:/index";
        }
        return "login2";
    }

    /**
     * POST 登录 shiro 写法
     *
     * @param username 用户名
     * @param password 密码
     * @return
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    public Object loginPost(String username, String password) {
        LOGGER.info("POST请求登录");

        if (StringUtils.isBlank(username)) {
            return renderError("用户名不能为空");
        }
        if (StringUtils.isBlank(password)) {
            return renderError("密码不能为空");
        }
        Subject user = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username, DigestUtils.md5Hex(password).toCharArray());
        token.setRememberMe(true);
        try {
            user.login(token);
        } catch (UnknownAccountException e) {
            LOGGER.error("账号不存在：{}", e);
            return renderError("账号不存在");
        } catch (DisabledAccountException e) {
            LOGGER.error("账号未启用：{}", e);
            return renderError("账号未启用");
        } catch (IncorrectCredentialsException e) {
            LOGGER.error("密码错误：{}", e);
            return renderError("密码错误");
        } catch (RuntimeException e) {
            LOGGER.error("未知错误,请联系管理员：{}", e);
            return renderError("未知错误,请联系管理员");
        }
        return renderSuccess();
    }
    
    /**
     * POST 登录 shiro 写法
     *
     * @param username 用户名
     * @param password 密码
     * @return
     */
    @RequestMapping(value = "/loginfg", method = RequestMethod.POST)
    @ResponseBody
    public Object loginPostfg(String username, String ok) {
        LOGGER.info("POST请求登录");

        if (StringUtils.isBlank(username)) {
            return renderError("用户名不能为空");
        }
        User user1 = null;
        if(ok != null && !ok.equals("")){
        	user1 = userService.findUserByLoginName(username);
        }
        
        if(!user1.getFingerPrint().equals(ok)){
        	return renderError("登录失败");
        }
        
        Subject user = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username, user1.getPassword().toCharArray());
        token.setRememberMe(true);
        try {
            user.login(token);
        } catch (UnknownAccountException e) {
            LOGGER.error("账号不存在：{}", e);
            return renderError("账号不存在");
        } catch (DisabledAccountException e) {
            LOGGER.error("账号未启用：{}", e);
            return renderError("账号未启用");
        } catch (IncorrectCredentialsException e) {
            LOGGER.error("密码错误：{}", e);
            return renderError("密码错误");
        } catch (RuntimeException e) {
            LOGGER.error("未知错误,请联系管理员：{}", e);
            return renderError("未知错误,请联系管理员");
        }
        return renderSuccess();
    }


    /**
     * 未授权
     * @return {String}
     */
    @RequestMapping(value = "/unauth")
    public String unauth() {
        if (SecurityUtils.getSubject().isAuthenticated() == false) {
            return "redirect:/login";
        }
        return "unauth";
    }

    /**
     * 退出
     * @return {Result}
     */
    @RequestMapping(value = "/logout")
    @ResponseBody
    public Object logout() {
        LOGGER.info("登出");
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return renderSuccess();
    }
}
