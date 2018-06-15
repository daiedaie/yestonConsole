package com.mrbt.yeston.web.model;

import java.io.Serializable;

public class YtBankAccountType implements Serializable {
    private Integer id;

    private String batName;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBatName() {
        return batName;
    }

    public void setBatName(String batName) {
        this.batName = batName == null ? null : batName.trim();
    }
}