/**
 *
 */
package com.mrbt.yeston.admin.commons.shiro;

import java.io.Serializable;
import java.util.List;

/**
 * @description：自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
public class ShiroUser implements Serializable {

    private static final long serialVersionUID = -1373760761780840081L;
    private Long id;
    private String loginName;
    private String name;
    private Integer deptId;
    private List<Long> roleList;

    public ShiroUser(Long id, String loginName, String name,Integer deptId, List<Long> roleList) {
        this.id = id;
        this.loginName = loginName;
        this.name = name;
        this.roleList = roleList;
        this.deptId = deptId;
    }

    public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}



	public List<Long> getRoleList() {
		return roleList;
	}



	public void setRoleList(List<Long> roleList) {
		this.roleList = roleList;
	}

	/**
     * 本函数输出将作为默认的<shiro:principal/>输出.
     */
    @Override
    public String toString() {
        return loginName;
    }
}