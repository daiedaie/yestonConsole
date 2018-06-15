package com.mrbt.yeston.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.commons.result.UserVo;
import com.mrbt.yeston.admin.commons.utils.DigestUtils;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.admin.commons.utils.StringUtils;
import com.mrbt.yeston.admin.model.Role;
import com.mrbt.yeston.admin.model.User;
import com.mrbt.yeston.admin.service.UserService;

/**
 * @description：用户管理
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    /**
     * 用户管理页
     *
     * @return
     */
    @RequestMapping(value = "/manager", method = RequestMethod.GET)
    public String manager() {
        return "admin/user";
    }

    /**
     * 用户管理列表
     *
     * @param userVo
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
    @ResponseBody
    public Object dataGrid(UserVo userVo, Integer page, Integer rows, String sort, String order) {
        PageInfo<T> pageInfo = new PageInfo<T>(page, rows);
        Map<String, Object> condition = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(userVo.getName())) {
            condition.put("name", userVo.getName());
        }
        if (userVo.getOrganizationId() != null) {
            condition.put("organizationId", userVo.getOrganizationId());
        }
        if (userVo.getCreatedateStart() != null) {
            condition.put("startTime", userVo.getCreatedateStart());
        }
        if (userVo.getCreatedateEnd() != null) {
            condition.put("endTime", userVo.getCreatedateEnd());
        }
        pageInfo.setCondition(condition);
        userService.findDataGrid(pageInfo);
        return pageInfo;
    }

    /**
     * 添加用户页
     *
     * @return
     */
    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public String addPage() {
        return "admin/userAdd";
    }

    /**
     * 添加用户
     *
     * @param userVo
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Object add(UserVo userVo) {
        try {
			User u = userService.findUserByLoginName(userVo.getLoginname());
			if (u != null) {
			    return renderError("用户名已存在!");
			}
			userVo.setPassword(DigestUtils.md5Hex(userVo.getPassword()));
			userService.addUser(userVo);
			return renderSuccess("添加成功");
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderSuccess("服务器出错");
		}
    }

    /**
     * 编辑用户页
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/editPage")
    public String editPage(Long id, Model model) {
        UserVo userVo = userService.findUserVoById(id);
        List<Role> rolesList = userVo.getRolesList();
        List<Long> ids = new ArrayList<Long>();
        for (Role role : rolesList) {
            ids.add(role.getId());
        }
        model.addAttribute("roleIds", ids);
        model.addAttribute("user", userVo);
        return "admin/userEdit";
    }

    /**
     * 编辑用户
     *
     * @param userVo
     * @return
     */
    @RequestMapping("/edit")
    @ResponseBody
    public Object edit(UserVo userVo) {
        try {
			User user = userService.findUserByLoginName(userVo.getLoginname());
			if (user != null && user.getId() != userVo.getId()) {
			    return renderError("用户名已存在!");
			}
			if(StringUtils.isNotBlank(userVo.getPassword())){
				userVo.setPassword(DigestUtils.md5Hex(userVo.getPassword()));
			}else{
				userVo.setPassword(null);
			}
			userService.updateUser(userVo);
			return renderSuccess("修改成功！");
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderSuccess("服务器出错");
		}
    }

    /**
     * 修改密码页
     *
     * @return
     */
    @RequestMapping(value = "/editPwdPage", method = RequestMethod.GET)
    public String editPwdPage() {
        return "admin/userEditPwd";
    }

    /**
     * 修改密码
     *
     * @param oldPwd
     * @param pwd
     * @return
     */
    @RequestMapping("/editUserPwd")
    @ResponseBody
    public Object editUserPwd(String oldPwd, String pwd) {
        if (!getCurrentUser().getPassword().equals(DigestUtils.md5Hex(oldPwd))) {
            return renderError("老密码不正确!");
        }

        userService.updateUserPwdById(getUserId(), DigestUtils.md5Hex(pwd));
        return renderSuccess("密码修改成功！");
    }

    /**
     * 删除用户
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        userService.deleteUserById(id);
        return renderSuccess("删除成功！");
    }
    
    /**
     * 验证用户是否存在
     * @param username
     * @return
     */
    @RequestMapping("/verifyHaveUser")
    @ResponseBody
    public Object verifyHaveUser(String username) {
    	User user = userService.verifyHaveUser(username);
    	if(user != null){
    		System.out.println(user.getFingerPrint() + "\n" + user.getFingerPrint2());
    		return renderSuccess(user.getFingerPrint() + ";" + user.getFingerPrint2());
    	}else{
    		return renderError("用户不存在");
    	}
    }
    
    @RequestMapping("/saveFingerPrint")
    @ResponseBody
    public Object saveFingerPrint(String fingerPrint, String username, String fingerPrint2) {
    	int res = userService.saveFingerPrint(fingerPrint, fingerPrint2, username);
    	if(res > 0){
    		return renderSuccess("保存成功");
    	}else{
    		return renderError("保存失败");
    	}
    }
}
