package com.mrbt.yeston.web.mapper;

import com.mrbt.yeston.web.model.YtCooperativeMain;
import com.mrbt.yeston.web.model.YtCooperativeMainExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YtCooperativeMainMapper {
    int countByExample(YtCooperativeMainExample example);

    int deleteByExample(YtCooperativeMainExample example);

    int deleteByPrimaryKey(String id);

    int insert(YtCooperativeMain record);

    int insertSelective(YtCooperativeMain record);

    List<YtCooperativeMain> selectByExample(YtCooperativeMainExample example);

    YtCooperativeMain selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") YtCooperativeMain record, @Param("example") YtCooperativeMainExample example);

    int updateByExample(@Param("record") YtCooperativeMain record, @Param("example") YtCooperativeMainExample example);

    int updateByPrimaryKeySelective(YtCooperativeMain record);

    int updateByPrimaryKey(YtCooperativeMain record);
}