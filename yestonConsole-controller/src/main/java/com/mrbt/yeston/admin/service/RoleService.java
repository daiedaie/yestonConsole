package com.mrbt.yeston.admin.service;

import com.mrbt.yeston.admin.model.Role;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.admin.commons.result.Tree;

import java.util.List;
import java.util.Map;

/**
 * @description：权限管理
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
public interface RoleService {
    /**
     * 查询权限列表
     *
     * @param pageInfo
     */
    void findDataGrid(PageInfo pageInfo);

    /**
     * 查询权限树
     *
     * @return
     */
    List<Tree> findTree();

    /**
     * 添加权限
     *
     * @param role
     */
    void addRole(Role role);

    /**
     * 根据id删除权限
     *
     * @param id
     */
    void deleteRoleById(Long id);

    /**
     * 根据id查询权限
     *
     * @param id
     * @return
     */
    Role findRoleById(Long id);

    /**
     * 更新权限
     *
     * @param role
     */
    void updateRole(Role role);

    /**
     * 根据权限id查询资源集合
     *
     * @param id
     * @return
     */
    List<Long> findResourceIdListByRoleId(Long id);

    /**
     * 更新权限和资源的关联关系
     *
     * @param id
     * @param resourceIds
     */
    void updateRoleResource(Long id, String resourceIds);

    /**
     * 根据用户查询id查询权限集合
     *
     * @param userId
     * @return
     */
    List<Long> findRoleIdListByUserId(Long userId);

    /**
     * 根据权限查询id查询资源路径集合
     *
     * @param roleId
     * @return
     */
    List<Map<Long, String>> findRoleResourceListByRoleId(Long roleId);

}
