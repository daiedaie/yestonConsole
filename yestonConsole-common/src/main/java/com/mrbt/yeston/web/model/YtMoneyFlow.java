package com.mrbt.yeston.web.model;

import java.io.Serializable;
import java.util.Date;

public class YtMoneyFlow implements Serializable {
    private String id;

    /**
     * 业务id
     */
    private String carLoanId;

    private String taskName;

    /**
     * 操作人id
     */
    private Integer uId;

    /**
     * 放款账户
     */
    private String fromAccount;

    /**
     * 放款账户名称
     */
    private String fromAccountName;

    /**
     * 放款账户开户行
     */
    private String fromAccountBankName;

    /**
     * 收款账户
     */
    private String toAccount;

    /**
     * 收款账户名称
     */
    private String toAccountName;

    /**
     * 收款账户开户行
     */
    private String toAccountBankName;

    /**
     * 金额
     */
    private Double money;

    /**
     * 操作时间
     */
    private Date addTime;

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getCarLoanId() {
        return carLoanId;
    }

    public void setCarLoanId(String carLoanId) {
        this.carLoanId = carLoanId == null ? null : carLoanId.trim();
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName == null ? null : taskName.trim();
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public String getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(String fromAccount) {
        this.fromAccount = fromAccount == null ? null : fromAccount.trim();
    }

    public String getFromAccountName() {
        return fromAccountName;
    }

    public void setFromAccountName(String fromAccountName) {
        this.fromAccountName = fromAccountName == null ? null : fromAccountName.trim();
    }

    public String getFromAccountBankName() {
        return fromAccountBankName;
    }

    public void setFromAccountBankName(String fromAccountBankName) {
        this.fromAccountBankName = fromAccountBankName == null ? null : fromAccountBankName.trim();
    }

    public String getToAccount() {
        return toAccount;
    }

    public void setToAccount(String toAccount) {
        this.toAccount = toAccount == null ? null : toAccount.trim();
    }

    public String getToAccountName() {
        return toAccountName;
    }

    public void setToAccountName(String toAccountName) {
        this.toAccountName = toAccountName == null ? null : toAccountName.trim();
    }

    public String getToAccountBankName() {
        return toAccountBankName;
    }

    public void setToAccountBankName(String toAccountBankName) {
        this.toAccountBankName = toAccountBankName == null ? null : toAccountBankName.trim();
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }
}