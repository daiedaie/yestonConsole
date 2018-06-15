package com.mrbt.yeston.web.mapper;

import com.mrbt.yeston.web.model.YtCarLoan;
import com.mrbt.yeston.web.model.YtCarLoanExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YtCarLoanMapper {
    int countByExample(YtCarLoanExample example);

    int deleteByExample(YtCarLoanExample example);

    int deleteByPrimaryKey(String id);

    int insert(YtCarLoan record);

    int insertSelective(YtCarLoan record);

    List<YtCarLoan> selectByExample(YtCarLoanExample example);

    YtCarLoan selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") YtCarLoan record, @Param("example") YtCarLoanExample example);

    int updateByExample(@Param("record") YtCarLoan record, @Param("example") YtCarLoanExample example);

    int updateByPrimaryKeySelective(YtCarLoan record);

    int updateByPrimaryKey(YtCarLoan record);
}