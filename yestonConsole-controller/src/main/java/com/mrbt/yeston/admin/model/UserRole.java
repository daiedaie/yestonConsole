package com.mrbt.yeston.admin.model;

import java.io.Serializable;

/**
 * @description：用户角色关联
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
public class UserRole implements Serializable {

    private static final long serialVersionUID = -8332992884983317378L;

    private Long id;

    private Long userId;

    private Long roleId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "UserRole{" +
                "id=" + id +
                ", userId=" + userId +
                ", roleId=" + roleId +
                '}';
    }
}