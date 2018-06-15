package com.mrbt.yeston.admin.model;

import java.io.Serializable;

/**
 * @description：角色资源关联
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
public class RoleResource implements Serializable {

    private static final long serialVersionUID = -7250242744961556986L;

    private Long id;

    private Long roleId;

    private Long resourceId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getResourceId() {
        return resourceId;
    }

    public void setResourceId(Long resourceId) {
        this.resourceId = resourceId;
    }

    @Override
    public String toString() {
        return "RoleResource {id=" + id + ", roleId=" + roleId + ", resourceId=" + resourceId + "}";
    }

}