package com.mrbt.yeston.web.mapper;

import com.mrbt.yeston.web.model.YtCooperativeContact;
import com.mrbt.yeston.web.model.YtCooperativeContactExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YtCooperativeContactMapper {
    int countByExample(YtCooperativeContactExample example);

    int deleteByExample(YtCooperativeContactExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(YtCooperativeContact record);

    int insertSelective(YtCooperativeContact record);

    List<YtCooperativeContact> selectByExample(YtCooperativeContactExample example);

    YtCooperativeContact selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") YtCooperativeContact record, @Param("example") YtCooperativeContactExample example);

    int updateByExample(@Param("record") YtCooperativeContact record, @Param("example") YtCooperativeContactExample example);

    int updateByPrimaryKeySelective(YtCooperativeContact record);

    int updateByPrimaryKey(YtCooperativeContact record);
}