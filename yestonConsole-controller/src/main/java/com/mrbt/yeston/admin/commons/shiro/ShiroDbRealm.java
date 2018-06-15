package com.mrbt.yeston.admin.commons.shiro;

import com.mrbt.yeston.admin.commons.utils.StringUtils;
import com.mrbt.yeston.admin.model.User;
import com.mrbt.yeston.admin.service.RoleService;
import com.mrbt.yeston.admin.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @description：shiro权限认证
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
public class ShiroDbRealm extends AuthorizingRealm {
    private static final Logger LOGGER = LogManager.getLogger(ShiroDbRealm.class);

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    /**
     * Shiro登录认证(原理：用户提交 用户名和密码  --- shiro 封装令牌 ---- realm 通过用户名将密码查询返回 ---- shiro 自动去比较查询出密码和用户输入密码是否一致---- 进行登陆控制 )
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken authcToken) throws AuthenticationException {
        LOGGER.info("Shiro开始登录认证");
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
        User user = userService.findUserByLoginName(token.getUsername());
        // 账号不存在
        if (user == null) {
            return null;
        }
        // 账号未启用
        if (user.getStatus() == 1) {
            return null;
        }
        List<Long> roleList = roleService.findRoleIdListByUserId(user.getId());
        ShiroUser shiroUser = new ShiroUser(user.getId(), user.getLoginname(), user.getName(),user.getOrganizationId(), roleList);
        // 认证缓存信息
        return new SimpleAuthenticationInfo(shiroUser, user.getPassword().toCharArray(), getName());

    }

    /**
     * Shiro权限认证
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(
            PrincipalCollection principals) {

        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        List<Long> roleList = shiroUser.getRoleList();

        Set<String> urlSet = new HashSet<String>();
        for (Long roleId : roleList) {
            List<Map<Long, String>> roleResourceList = roleService.findRoleResourceListByRoleId(roleId);
            if (roleResourceList != null && roleResourceList.size() > 0) {
                for (Map<Long, String> map : roleResourceList) {
                    if (StringUtils.isNotBlank(map.get("url"))) {
                        urlSet.add(map.get("url"));
                    }
                }
            }
        }
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.addStringPermissions(urlSet);
        return info;
    }
}
