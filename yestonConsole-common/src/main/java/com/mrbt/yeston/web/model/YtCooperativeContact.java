package com.mrbt.yeston.web.model;

import java.io.Serializable;
import java.util.Date;

public class YtCooperativeContact implements Serializable {
    private Integer id;

    /**
     * 联系类型，公司或联系人姓名
     */
    private String linkman;

    /**
     * 固定电话
     */
    private String fixedTelphone;

    /**
     * 手机号
     */
    private String mobilePhone;

    /**
     * 传真
     */
    private String faxPhone;

    /**
     * 地址
     */
    private String address;

    /**
     * email
     */
    private String email;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date modiTime;

    /**
     * 状态，0删除，1正常
     */
    private Integer status;

    /**
     * 合作机构公司ID,yt_supplier_main.id
     */
    private String cooperativeId;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLinkman() {
        return linkman;
    }

    public void setLinkman(String linkman) {
        this.linkman = linkman == null ? null : linkman.trim();
    }

    public String getFixedTelphone() {
        return fixedTelphone;
    }

    public void setFixedTelphone(String fixedTelphone) {
        this.fixedTelphone = fixedTelphone == null ? null : fixedTelphone.trim();
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone == null ? null : mobilePhone.trim();
    }

    public String getFaxPhone() {
        return faxPhone;
    }

    public void setFaxPhone(String faxPhone) {
        this.faxPhone = faxPhone == null ? null : faxPhone.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModiTime() {
        return modiTime;
    }

    public void setModiTime(Date modiTime) {
        this.modiTime = modiTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCooperativeId() {
        return cooperativeId;
    }

    public void setCooperativeId(String cooperativeId) {
        this.cooperativeId = cooperativeId == null ? null : cooperativeId.trim();
    }
}