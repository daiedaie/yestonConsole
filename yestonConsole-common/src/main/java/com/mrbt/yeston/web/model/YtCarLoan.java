package com.mrbt.yeston.web.model;

import java.io.Serializable;
import java.util.Date;

public class YtCarLoan implements Serializable {
    /**
     * UUID
     */
    private String id;

    /**
     * 车牌号
     */
    private String plateNumber;

    /**
     * 车辆所属，1-个人，2-公司，？
     */
    private Integer vehicleOwnership;

    /**
     * 车主姓名
     */
    private String ownerName;

    /**
     * 是否营运，0否，1是
     */
    private Integer whetherOperation;

    /**
     * 车辆型号
     */
    private String vehicleType;

    /**
     * 车辆年限，不足一个月按照整月处理 ？
     */
    private Integer vehicleLife;

    /**
     * 行驶公里数
     */
    private Double kilometers;

    /**
     * 借款金额
     */
    private Double loanAmount;

    /**
     * 借款期限 ?
     */
    private Integer loanTerm;

    /**
     * 单押/双押   1：单押，2：双押
     */
    private Integer singleDoubleCharge;

    /**
     * 一抵押/二抵押    1一抵押，2二抵押
     */
    private Integer dollarsNumber;

    /**
     * 如果抵押为二抵，需要备注填写一抵押人，上一抵押人
     */
    private String oneDollarsName;

    /**
     * 还款方式，1：转账
     */
    private Integer repaymentMethod;

    /**
     * 利率
     */
    private Double rate;

    /**
     * 行驶本
     */
    private String travelBook;

    /**
     * 证件类型，1身份证，2，营业执照
     */
    private Integer documentType;

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

    /**
     * 审核状态
     */
    private Integer status;

    /**
     * 供应商id 
     */
    private String cooperateId;

    /**
     * 申请人用户ID
     */
    private Integer userId;

    /**
     * 预计还款金额
     */
    private Double estRepAmount;

    /**
     * 实际还款金额
     */
    private Double actRepAmount;

    /**
     * 借款时间
     */
    private Date loanTime;

    /**
     * 业务类型
     */
    private Integer businessType;

    /**
     * 产品id
     */
    private Integer productId;

    /**
     * 发起时间
     */
    private Date startTime;

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber == null ? null : plateNumber.trim();
    }

    public Integer getVehicleOwnership() {
        return vehicleOwnership;
    }

    public void setVehicleOwnership(Integer vehicleOwnership) {
        this.vehicleOwnership = vehicleOwnership;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName == null ? null : ownerName.trim();
    }

    public Integer getWhetherOperation() {
        return whetherOperation;
    }

    public void setWhetherOperation(Integer whetherOperation) {
        this.whetherOperation = whetherOperation;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType == null ? null : vehicleType.trim();
    }

    public Integer getVehicleLife() {
        return vehicleLife;
    }

    public void setVehicleLife(Integer vehicleLife) {
        this.vehicleLife = vehicleLife;
    }

    public Double getKilometers() {
        return kilometers;
    }

    public void setKilometers(Double kilometers) {
        this.kilometers = kilometers;
    }

    public Double getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(Double loanAmount) {
        this.loanAmount = loanAmount;
    }

    public Integer getLoanTerm() {
        return loanTerm;
    }

    public void setLoanTerm(Integer loanTerm) {
        this.loanTerm = loanTerm;
    }

    public Integer getSingleDoubleCharge() {
        return singleDoubleCharge;
    }

    public void setSingleDoubleCharge(Integer singleDoubleCharge) {
        this.singleDoubleCharge = singleDoubleCharge;
    }

    public Integer getDollarsNumber() {
        return dollarsNumber;
    }

    public void setDollarsNumber(Integer dollarsNumber) {
        this.dollarsNumber = dollarsNumber;
    }

    public String getOneDollarsName() {
        return oneDollarsName;
    }

    public void setOneDollarsName(String oneDollarsName) {
        this.oneDollarsName = oneDollarsName == null ? null : oneDollarsName.trim();
    }

    public Integer getRepaymentMethod() {
        return repaymentMethod;
    }

    public void setRepaymentMethod(Integer repaymentMethod) {
        this.repaymentMethod = repaymentMethod;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public String getTravelBook() {
        return travelBook;
    }

    public void setTravelBook(String travelBook) {
        this.travelBook = travelBook == null ? null : travelBook.trim();
    }

    public Integer getDocumentType() {
        return documentType;
    }

    public void setDocumentType(Integer documentType) {
        this.documentType = documentType;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCooperateId() {
        return cooperateId;
    }

    public void setCooperateId(String cooperateId) {
        this.cooperateId = cooperateId == null ? null : cooperateId.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Double getEstRepAmount() {
        return estRepAmount;
    }

    public void setEstRepAmount(Double estRepAmount) {
        this.estRepAmount = estRepAmount;
    }

    public Double getActRepAmount() {
        return actRepAmount;
    }

    public void setActRepAmount(Double actRepAmount) {
        this.actRepAmount = actRepAmount;
    }

    public Date getLoanTime() {
        return loanTime;
    }

    public void setLoanTime(Date loanTime) {
        this.loanTime = loanTime;
    }

    public Integer getBusinessType() {
        return businessType;
    }

    public void setBusinessType(Integer businessType) {
        this.businessType = businessType;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }
}