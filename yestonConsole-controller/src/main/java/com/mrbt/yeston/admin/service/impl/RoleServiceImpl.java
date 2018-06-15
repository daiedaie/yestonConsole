package com.mrbt.yeston.admin.service.impl;

import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.mapper.RoleMapper;
import com.mrbt.yeston.admin.mapper.RoleResourceMapper;
import com.mrbt.yeston.admin.mapper.UserRoleMapper;
import com.mrbt.yeston.admin.model.Role;
import com.mrbt.yeston.admin.model.RoleResource;
import com.mrbt.yeston.admin.service.RoleService;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.admin.commons.result.Tree;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {
    private static final Logger LOGGER = LogManager.getLogger(RoleServiceImpl.class);

    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private RoleResourceMapper roleResourceMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public void findDataGrid(PageInfo pageInfo) {
        pageInfo.setRows(roleMapper.findRolePageCondition(pageInfo));
        pageInfo.setTotal(roleMapper.findRolePageCount(pageInfo));
    }

    @Override
    public List<Tree> findTree() {
        List<Tree> trees = new ArrayList<Tree>();
        List<Role> roles = roleMapper.findRoleAll();
        for (Role role : roles) {
            Tree tree = new Tree();
            tree.setId(role.getId());
            tree.setText(role.getName());

            trees.add(tree);
        }
        return trees;
    }

    @Override
    public void addRole(Role role) {
        int insert = roleMapper.insert(role);
        // 同时添加到工作流表中
        if (insert != 1) {
            LOGGER.warn("插入失败，参数：{}", role.toString());
            throw new ServiceException("插入失败");
        }
    }

    @Override
    public void deleteRoleById(Long id) {
        int update = roleMapper.deleteRoleById(id);
        if (update != 1) {
            LOGGER.warn("删除失败，id：{}", id);
            throw new ServiceException("删除失败");
        }
    }

    @Override
    public Role findRoleById(Long id) {
        return roleMapper.findRoleById(id);
    }

    @Override
    public void updateRole(Role role) {
        int update = roleMapper.updateRole(role);
        if (update != 1) {
            LOGGER.warn("更新失败，参数：{}", role.toString());
            throw new ServiceException("更新失败");
        }
    }

    @Override
    public List<Long> findResourceIdListByRoleId(Long id) {
        return roleMapper.findResourceIdListByRoleId(id);
    }

    @Override
    public void updateRoleResource(Long id, String resourceIds) {
        // 先删除后添加,有点爆力
        List<Long> roleResourceIdList = roleMapper.findRoleResourceIdListByRoleId(id);
        if (roleResourceIdList != null && (!roleResourceIdList.isEmpty())) {
            for (Long roleResourceId : roleResourceIdList) {
                roleResourceMapper.deleteById(roleResourceId);
            }
        }
        String[] resources = resourceIds.split(",");
        RoleResource roleResource = new RoleResource();
        for (String string : resources) {
            roleResource.setRoleId(id);
            roleResource.setResourceId(Long.parseLong(string));
            roleResourceMapper.insert(roleResource);
        }
    }

    @Override
    public List<Long> findRoleIdListByUserId(Long userId) {
        return userRoleMapper.findRoleIdListByUserId(userId);
    }

    @Override
    public List<Map<Long, String>> findRoleResourceListByRoleId(Long roleId) {
        return roleMapper.findRoleResourceListByRoleId(roleId);
    }

}
