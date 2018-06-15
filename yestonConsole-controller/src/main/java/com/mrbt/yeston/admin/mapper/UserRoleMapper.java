package com.mrbt.yeston.admin.mapper;

import java.util.List;

import com.mrbt.yeston.admin.model.UserRole;

public interface UserRoleMapper {

    int insert(UserRole userRole);

    int updateByPrimaryKeySelective(UserRole userRole);

    List<UserRole> findUserRoleByUserId(Long userId);

    int deleteById(Long id);

    List<Long> findRoleIdListByUserId(Long userId);
    
    String findRoleNameById(Long roleId);
}