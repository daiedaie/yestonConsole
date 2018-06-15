package com.mrbt.yeston.web.model;

import java.io.Serializable;
import java.util.Date;

public class ScheduleJob implements Serializable {
	public static final Integer STATUS_INIT = 0;  
	public static final Integer STATUS_RUNNING = 1;
	public static final Integer STATUS_PAUSE = 2;
	public static final Integer STATUS_REMOVE = 3;
	public static final Integer CONCURRENT_IS = 1;
	public static final Integer CONCURRENT_NOT = 0;
    /**
     * 任务id
     * 表字段 : schedule_job.job_id
     */
    private Integer jobId;

    /**
     * 任务名称
     * 表字段 : schedule_job.job_name
     */
    private String jobName;

    /**
     * 任务分组
     * 表字段 : schedule_job.job_group
     */
    private String jobGroup;

    /**
     * cron表达式
     * 表字段 : schedule_job.cron_Expression
     */
    private String cronExpression;

    /**
     * 描述
     * 表字段 : schedule_job.description
     */
    private String description;

    /**
     * 任务执行时调用哪个类的方法 包名+类名
     * 表字段 : schedule_job.bean_class
     */
    private String beanClass;

    /**
     * 是否允许并发 0 否 1是
     * 表字段 : schedule_job.is_concurrent
     */
    private Integer isConcurrent;

    /**
     * spring bean
     * 表字段 : schedule_job.spring_id
     */
    private String springId;

    /**
     * 任务调用的方法名
     * 表字段 : schedule_job.method_name
     */
    private String methodName;

    /**
     * 任务状态 0-停止 1启动 2暂停 3删除
     * 表字段 : schedule_job.job_status
     */
    private Integer jobStatus;

    /**
     * 创建时间
     * 表字段 : schedule_job.create_time
     */
    private Date createTime;

    /**
     * 更新时间
     * 表字段 : schedule_job.update_time
     */
    private Date updateTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table schedule_job
     *
     * @mbggenerated
     */
    private static final long serialVersionUID = 1L;

    /**
     * 获取 任务id 字段:schedule_job.job_id
     *
     * @return schedule_job.job_id, 任务id
     */
    public Integer getJobId() {
        return jobId;
    }

    /**
     * 设置 任务id 字段:schedule_job.job_id
     *
     * @param jobId the value for schedule_job.job_id, 任务id
     */
    public void setJobId(Integer jobId) {
        this.jobId = jobId;
    }

    /**
     * 获取 任务名称 字段:schedule_job.job_name
     *
     * @return schedule_job.job_name, 任务名称
     */
    public String getJobName() {
        return jobName;
    }

    /**
     * 设置 任务名称 字段:schedule_job.job_name
     *
     * @param jobName the value for schedule_job.job_name, 任务名称
     */
    public void setJobName(String jobName) {
        this.jobName = jobName == null ? null : jobName.trim();
    }

    /**
     * 获取 任务分组 字段:schedule_job.job_group
     *
     * @return schedule_job.job_group, 任务分组
     */
    public String getJobGroup() {
        return jobGroup;
    }

    /**
     * 设置 任务分组 字段:schedule_job.job_group
     *
     * @param jobGroup the value for schedule_job.job_group, 任务分组
     */
    public void setJobGroup(String jobGroup) {
        this.jobGroup = jobGroup == null ? null : jobGroup.trim();
    }

    /**
     * 获取 cron表达式 字段:schedule_job.cron_Expression
     *
     * @return schedule_job.cron_Expression, cron表达式
     */
    public String getCronExpression() {
        return cronExpression;
    }

    /**
     * 设置 cron表达式 字段:schedule_job.cron_Expression
     *
     * @param cronExpression the value for schedule_job.cron_Expression, cron表达式
     */
    public void setCronExpression(String cronExpression) {
        this.cronExpression = cronExpression == null ? null : cronExpression.trim();
    }

    /**
     * 获取 描述 字段:schedule_job.description
     *
     * @return schedule_job.description, 描述
     */
    public String getDescription() {
        return description;
    }

    /**
     * 设置 描述 字段:schedule_job.description
     *
     * @param description the value for schedule_job.description, 描述
     */
    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    /**
     * 获取 任务执行时调用哪个类的方法 包名+类名 字段:schedule_job.bean_class
     *
     * @return schedule_job.bean_class, 任务执行时调用哪个类的方法 包名+类名
     */
    public String getBeanClass() {
        return beanClass;
    }

    /**
     * 设置 任务执行时调用哪个类的方法 包名+类名 字段:schedule_job.bean_class
     *
     * @param beanClass the value for schedule_job.bean_class, 任务执行时调用哪个类的方法 包名+类名
     */
    public void setBeanClass(String beanClass) {
        this.beanClass = beanClass == null ? null : beanClass.trim();
    }

    /**
     * 获取 是否允许并发 0 否 1是 字段:schedule_job.is_concurrent
     *
     * @return schedule_job.is_concurrent, 是否允许并发 0 否 1是
     */
    public Integer getIsConcurrent() {
        return isConcurrent;
    }

    /**
     * 设置 是否允许并发 0 否 1是 字段:schedule_job.is_concurrent
     *
     * @param isConcurrent the value for schedule_job.is_concurrent, 是否允许并发 0 否 1是
     */
    public void setIsConcurrent(Integer isConcurrent) {
        this.isConcurrent = isConcurrent;
    }

    /**
     * 获取 spring bean 字段:schedule_job.spring_id
     *
     * @return schedule_job.spring_id, spring bean
     */
    public String getSpringId() {
        return springId;
    }

    /**
     * 设置 spring bean 字段:schedule_job.spring_id
     *
     * @param springId the value for schedule_job.spring_id, spring bean
     */
    public void setSpringId(String springId) {
        this.springId = springId == null ? null : springId.trim();
    }

    /**
     * 获取 任务调用的方法名 字段:schedule_job.method_name
     *
     * @return schedule_job.method_name, 任务调用的方法名
     */
    public String getMethodName() {
        return methodName;
    }

    /**
     * 设置 任务调用的方法名 字段:schedule_job.method_name
     *
     * @param methodName the value for schedule_job.method_name, 任务调用的方法名
     */
    public void setMethodName(String methodName) {
        this.methodName = methodName == null ? null : methodName.trim();
    }

    /**
     * 获取 任务状态 0-停止 1启动 2暂停 3删除 字段:schedule_job.job_status
     *
     * @return schedule_job.job_status, 任务状态 0-停止 1启动 2暂停 3删除
     */
    public Integer getJobStatus() {
        return jobStatus;
    }

    /**
     * 设置 任务状态 0-停止 1启动 2暂停 3删除 字段:schedule_job.job_status
     *
     * @param jobStatus the value for schedule_job.job_status, 任务状态 0-停止 1启动 2暂停 3删除
     */
    public void setJobStatus(Integer jobStatus) {
        this.jobStatus = jobStatus;
    }

    /**
     * 获取 创建时间 字段:schedule_job.create_time
     *
     * @return schedule_job.create_time, 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置 创建时间 字段:schedule_job.create_time
     *
     * @param createTime the value for schedule_job.create_time, 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * 获取 更新时间 字段:schedule_job.update_time
     *
     * @return schedule_job.update_time, 更新时间
     */
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 设置 更新时间 字段:schedule_job.update_time
     *
     * @param updateTime the value for schedule_job.update_time, 更新时间
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    /**
     * ,schedule_job
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", jobId=").append(jobId);
        sb.append(", jobName=").append(jobName);
        sb.append(", jobGroup=").append(jobGroup);
        sb.append(", cronExpression=").append(cronExpression);
        sb.append(", description=").append(description);
        sb.append(", beanClass=").append(beanClass);
        sb.append(", isConcurrent=").append(isConcurrent);
        sb.append(", springId=").append(springId);
        sb.append(", methodName=").append(methodName);
        sb.append(", jobStatus=").append(jobStatus);
        sb.append(", createTime=").append(createTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append("]");
        return sb.toString();
    }
}