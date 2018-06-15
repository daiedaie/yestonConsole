package com.mrbt.yeston.web.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.mrbt.yeston.web.model.ScheduleLog;
import com.mrbt.yeston.web.model.ScheduleLogExample;

public interface ScheduleLogMapper {
    /**
     *  根据指定的条件获取数据库记录数,schedule_log
     *
     * @param example
     */
    int countByExample(ScheduleLogExample example);

    /**
     *  根据指定的条件删除数据库符合条件的记录,schedule_log
     *
     * @param example
     */
    int deleteByExample(ScheduleLogExample example);

    /**
     *  根据主键删除数据库的记录,schedule_log
     *
     * @param id
     */
    int deleteByPrimaryKey(Integer id);

    /**
     *  新写入数据库记录,schedule_log
     *
     * @param record
     */
    int insert(ScheduleLog record);

    /**
     *  动态字段,写入数据库记录,schedule_log
     *
     * @param record
     */
    int insertSelective(ScheduleLog record);

    /**
     * ,schedule_log
     *
     * @param example
     */
    List<ScheduleLog> selectByExampleWithBLOBs(ScheduleLogExample example);

    /**
     *  根据指定的条件查询符合条件的数据库记录,schedule_log
     *
     * @param example
     */
    List<ScheduleLog> selectByExample(ScheduleLogExample example);

    /**
     *  根据指定主键获取一条数据库记录,schedule_log
     *
     * @param id
     */
    ScheduleLog selectByPrimaryKey(Integer id);

    /**
     *  动态根据指定的条件来更新符合条件的数据库记录,schedule_log
     *
     * @param record
     * @param example
     */
    int updateByExampleSelective(@Param("record") ScheduleLog record, @Param("example") ScheduleLogExample example);

    /**
     * ,schedule_log
     *
     * @param record
     * @param example
     */
    int updateByExampleWithBLOBs(@Param("record") ScheduleLog record, @Param("example") ScheduleLogExample example);

    /**
     *  根据指定的条件来更新符合条件的数据库记录,schedule_log
     *
     * @param record
     * @param example
     */
    int updateByExample(@Param("record") ScheduleLog record, @Param("example") ScheduleLogExample example);

    /**
     *  动态字段,根据主键来更新符合条件的数据库记录,schedule_log
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ScheduleLog record);

    /**
     * ,schedule_log
     *
     * @param record
     */
    int updateByPrimaryKeyWithBLOBs(ScheduleLog record);

    /**
     *  根据主键来更新符合条件的数据库记录,schedule_log
     *
     * @param record
     */
    int updateByPrimaryKey(ScheduleLog record);
}