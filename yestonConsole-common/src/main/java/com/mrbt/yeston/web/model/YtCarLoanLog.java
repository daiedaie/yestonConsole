package com.mrbt.yeston.web.model;

import java.io.Serializable;
import java.util.Date;

public class YtCarLoanLog implements Serializable {
    private Integer id;

    /**
     * 操作状态
     */
    private Integer status;

    /**
     * 记录信息
     */
    private String operInfo;

    /**
     * 操作时间
     */
    private Date operTime;

    /**
     * 操作人ID
     */
    private Integer operUserId;

    /**
     * 对应的车贷宝业务表ID
     */
    private String carLoanId;

    /**
     * 相关凭证，图片
     */
    private String voucher;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getOperInfo() {
        return operInfo;
    }

    public void setOperInfo(String operInfo) {
        this.operInfo = operInfo == null ? null : operInfo.trim();
    }

    public Date getOperTime() {
        return operTime;
    }

    public void setOperTime(Date operTime) {
        this.operTime = operTime;
    }

    public Integer getOperUserId() {
        return operUserId;
    }

    public void setOperUserId(Integer operUserId) {
        this.operUserId = operUserId;
    }

    public String getCarLoanId() {
        return carLoanId;
    }

    public void setCarLoanId(String carLoanId) {
        this.carLoanId = carLoanId == null ? null : carLoanId.trim();
    }

    public String getVoucher() {
        return voucher;
    }

    public void setVoucher(String voucher) {
        this.voucher = voucher == null ? null : voucher.trim();
    }
}