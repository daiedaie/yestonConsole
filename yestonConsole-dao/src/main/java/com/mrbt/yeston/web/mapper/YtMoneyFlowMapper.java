package com.mrbt.yeston.web.mapper;

import com.mrbt.yeston.web.model.YtMoneyFlow;
import com.mrbt.yeston.web.model.YtMoneyFlowExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YtMoneyFlowMapper {
    int countByExample(YtMoneyFlowExample example);

    int deleteByExample(YtMoneyFlowExample example);

    int deleteByPrimaryKey(String id);

    int insert(YtMoneyFlow record);

    int insertSelective(YtMoneyFlow record);

    List<YtMoneyFlow> selectByExample(YtMoneyFlowExample example);

    YtMoneyFlow selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") YtMoneyFlow record, @Param("example") YtMoneyFlowExample example);

    int updateByExample(@Param("record") YtMoneyFlow record, @Param("example") YtMoneyFlowExample example);

    int updateByPrimaryKeySelective(YtMoneyFlow record);

    int updateByPrimaryKey(YtMoneyFlow record);
}