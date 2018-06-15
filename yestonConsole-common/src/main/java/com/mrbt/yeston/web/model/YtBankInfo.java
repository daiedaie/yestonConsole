package com.mrbt.yeston.web.model;

import java.io.Serializable;
import java.util.Date;

public class YtBankInfo implements Serializable {
    private String id;

    /**
     * 0:未启用，1:已启用，2:已作废
     */
    private Integer status;

    /**
     * 账户类型，yt_bank_account_type.id
     */
    private Integer type;
    private String typeName;

    /**
     * 合作机构公司id,yt_supplier_main.id
     */
    private String cooperativeId;

    /**
     * 银行账户
     */
    private String bankAccount;

    /**
     * 账户姓名
     */
    private String bankAccountName;

    private String bank;

    /**
     * 开户行
     */
    private String bankName;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 作废时间
     */
    private Date cancelTime;

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getCooperativeId() {
        return cooperativeId;
    }

    public void setCooperativeId(String cooperativeId) {
        this.cooperativeId = cooperativeId == null ? null : cooperativeId.trim();
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount == null ? null : bankAccount.trim();
    }

    public String getBankAccountName() {
        return bankAccountName;
    }

    public void setBankAccountName(String bankAccountName) {
        this.bankAccountName = bankAccountName == null ? null : bankAccountName.trim();
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank == null ? null : bank.trim();
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName == null ? null : bankName.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(Date cancelTime) {
        this.cancelTime = cancelTime;
    }
}