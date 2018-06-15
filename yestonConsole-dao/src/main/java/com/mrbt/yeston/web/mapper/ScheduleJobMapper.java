package com.mrbt.yeston.web.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.mrbt.yeston.web.model.ScheduleJob;
import com.mrbt.yeston.web.model.ScheduleJobExample;


public interface ScheduleJobMapper {
    /**
     *  根据指定的条件获取数据库记录数,schedule_job
     *
     * @param example
     */
    int countByExample(ScheduleJobExample example);

    /**
     *  根据指定的条件删除数据库符合条件的记录,schedule_job
     *
     * @param example
     */
    int deleteByExample(ScheduleJobExample example);

    /**
     *  根据主键删除数据库的记录,schedule_job
     *
     * @param jobId
     */
    int deleteByPrimaryKey(Integer jobId);

    /**
     *  新写入数据库记录,schedule_job
     *
     * @param record
     */
    int insert(ScheduleJob record);

    /**
     *  动态字段,写入数据库记录,schedule_job
     *
     * @param record
     */
    int insertSelective(ScheduleJob record);

    /**
     *  根据指定的条件查询符合条件的数据库记录,schedule_job
     *
     * @param example
     */
    List<ScheduleJob> selectByExample(ScheduleJobExample example);

    /**
     *  根据指定主键获取一条数据库记录,schedule_job
     *
     * @param jobId
     */
    ScheduleJob selectByPrimaryKey(Integer jobId);

    /**
     *  动态根据指定的条件来更新符合条件的数据库记录,schedule_job
     *
     * @param record
     * @param example
     */
    int updateByExampleSelective(@Param("record") ScheduleJob record, @Param("example") ScheduleJobExample example);

    /**
     *  根据指定的条件来更新符合条件的数据库记录,schedule_job
     *
     * @param record
     * @param example
     */
    int updateByExample(@Param("record") ScheduleJob record, @Param("example") ScheduleJobExample example);

    /**
     *  动态字段,根据主键来更新符合条件的数据库记录,schedule_job
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ScheduleJob record);

    /**
     *  根据主键来更新符合条件的数据库记录,schedule_job
     *
     * @param record
     */
    int updateByPrimaryKey(ScheduleJob record);
}