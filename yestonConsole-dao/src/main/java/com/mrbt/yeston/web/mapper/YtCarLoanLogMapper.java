package com.mrbt.yeston.web.mapper;

import com.mrbt.yeston.web.model.YtCarLoanLog;
import com.mrbt.yeston.web.model.YtCarLoanLogExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YtCarLoanLogMapper {
    int countByExample(YtCarLoanLogExample example);

    int deleteByExample(YtCarLoanLogExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(YtCarLoanLog record);

    int insertSelective(YtCarLoanLog record);

    List<YtCarLoanLog> selectByExample(YtCarLoanLogExample example);

    YtCarLoanLog selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") YtCarLoanLog record, @Param("example") YtCarLoanLogExample example);

    int updateByExample(@Param("record") YtCarLoanLog record, @Param("example") YtCarLoanLogExample example);

    int updateByPrimaryKeySelective(YtCarLoanLog record);

    int updateByPrimaryKey(YtCarLoanLog record);
}