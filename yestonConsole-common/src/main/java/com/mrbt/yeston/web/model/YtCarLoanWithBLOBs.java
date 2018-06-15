package com.mrbt.yeston.web.model;

import java.io.Serializable;

public class YtCarLoanWithBLOBs extends YtCarLoan implements Serializable {
    /**
     * 行驶本
     */
    private String travelBook;

    /**
     * 身份证或营业执照
     */
    private String idcardLicense;

    /**
     * 车辆评估报告
     */
    private String vehicleEvaluationReport;

    /**
     * 委托借款协议
     */
    private String loanAgreement;

    /**
     * 机动车登记证
     */
    private String vehicleCertificate;

    /**
     * 车辆购置完税证明
     */
    private String vehicleTaxCertificate;

    /**
     * 车辆发票
     */
    private String vehicalInvoice;

    /**
     * 车辆照片
     */
    private String vehicalPhoto;

    /**
     * 借款合同
     */
    private String loanContract;

    /**
     * 借条
     */
    private String iou;

    /**
     * 资金需求表
     */
    private String capitalRequirement;

    /**
     * 保单
     */
    private String policy;

    /**
     * 机动车封存清单
     */
    private String vehicleInventory;

    private static final long serialVersionUID = 1L;

    public String getTravelBook() {
        return travelBook;
    }

    public void setTravelBook(String travelBook) {
        this.travelBook = travelBook == null ? null : travelBook.trim();
    }

    public String getIdcardLicense() {
        return idcardLicense;
    }

    public void setIdcardLicense(String idcardLicense) {
        this.idcardLicense = idcardLicense == null ? null : idcardLicense.trim();
    }

    public String getVehicleEvaluationReport() {
        return vehicleEvaluationReport;
    }

    public void setVehicleEvaluationReport(String vehicleEvaluationReport) {
        this.vehicleEvaluationReport = vehicleEvaluationReport == null ? null : vehicleEvaluationReport.trim();
    }

    public String getLoanAgreement() {
        return loanAgreement;
    }

    public void setLoanAgreement(String loanAgreement) {
        this.loanAgreement = loanAgreement == null ? null : loanAgreement.trim();
    }

    public String getVehicleCertificate() {
        return vehicleCertificate;
    }

    public void setVehicleCertificate(String vehicleCertificate) {
        this.vehicleCertificate = vehicleCertificate == null ? null : vehicleCertificate.trim();
    }

    public String getVehicleTaxCertificate() {
        return vehicleTaxCertificate;
    }

    public void setVehicleTaxCertificate(String vehicleTaxCertificate) {
        this.vehicleTaxCertificate = vehicleTaxCertificate == null ? null : vehicleTaxCertificate.trim();
    }

    public String getVehicalInvoice() {
        return vehicalInvoice;
    }

    public void setVehicalInvoice(String vehicalInvoice) {
        this.vehicalInvoice = vehicalInvoice == null ? null : vehicalInvoice.trim();
    }

    public String getVehicalPhoto() {
        return vehicalPhoto;
    }

    public void setVehicalPhoto(String vehicalPhoto) {
        this.vehicalPhoto = vehicalPhoto == null ? null : vehicalPhoto.trim();
    }

    public String getLoanContract() {
        return loanContract;
    }

    public void setLoanContract(String loanContract) {
        this.loanContract = loanContract == null ? null : loanContract.trim();
    }

    public String getIou() {
        return iou;
    }

    public void setIou(String iou) {
        this.iou = iou == null ? null : iou.trim();
    }

    public String getCapitalRequirement() {
        return capitalRequirement;
    }

    public void setCapitalRequirement(String capitalRequirement) {
        this.capitalRequirement = capitalRequirement == null ? null : capitalRequirement.trim();
    }

    public String getPolicy() {
        return policy;
    }

    public void setPolicy(String policy) {
        this.policy = policy == null ? null : policy.trim();
    }

    public String getVehicleInventory() {
        return vehicleInventory;
    }

    public void setVehicleInventory(String vehicleInventory) {
        this.vehicleInventory = vehicleInventory == null ? null : vehicleInventory.trim();
    }
}