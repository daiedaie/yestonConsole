package com.mrbt.yeston.admin.mapper;

import com.mrbt.yeston.admin.model.RoleResource;

import java.util.List;

public interface RoleResourceMapper {
    /**
     * 添加角色资源关联
     *
     * @param roleResource
     * @return
     */
    int insert(RoleResource roleResource);

    /**
     * 根据角色id查询角色资源关联列表
     *
     * @param id
     * @return
     */
    List<RoleResource> findRoleResourceIdListByRoleId(Long id);

    /**
     * 删除角色资源关联关系
     *
     * @param roleResourceId
     * @return
     */
    int deleteById(Long roleResourceId);
}