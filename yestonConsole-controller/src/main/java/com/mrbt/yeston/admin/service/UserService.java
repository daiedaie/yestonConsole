package com.mrbt.yeston.admin.service;

import com.mrbt.yeston.admin.model.User;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.admin.commons.result.UserVo;

/**
 * @description：用户管理
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
public interface UserService {
    /**
     * 根据用户名查询用户
     *
     * @param username
     * @return
     */
    User findUserByLoginName(String username);

    /**
     * 根据用户id查询用户
     *
     * @param id
     * @return
     */
    User findUserById(Long id);

    /**
     * 用户列表
     *
     * @param pageInfo
     */
    void findDataGrid(PageInfo pageInfo);

    /**
     * 添加用户
     *
     * @param userVo
     */
    void addUser(UserVo userVo);

    /**
     * 修改密码
     *
     * @param userId
     * @param pwd
     */
    void updateUserPwdById(Long userId, String pwd);

    /**
     * 根据用户id查询用户带部门
     *
     * @param id
     * @return
     */
    UserVo findUserVoById(Long id);

    /**
     * 修改用户
     *
     * @param userVo
     */
    void updateUser(UserVo userVo);

    /**
     * 删除用户
     *
     * @param id
     */
    void deleteUserById(Long id);

    User verifyHaveUser(String username);

	int saveFingerPrint(String fingerPrint, String fingerPrint2, String username);

}
