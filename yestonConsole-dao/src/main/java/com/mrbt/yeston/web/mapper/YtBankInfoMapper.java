package com.mrbt.yeston.web.mapper;

import com.mrbt.yeston.web.model.YtBankInfo;
import com.mrbt.yeston.web.model.YtBankInfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YtBankInfoMapper {
    int countByExample(YtBankInfoExample example);

    int deleteByExample(YtBankInfoExample example);

    int deleteByPrimaryKey(String id);

    int insert(YtBankInfo record);

    int insertSelective(YtBankInfo record);

    List<YtBankInfo> selectByExample(YtBankInfoExample example);

    YtBankInfo selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") YtBankInfo record, @Param("example") YtBankInfoExample example);

    int updateByExample(@Param("record") YtBankInfo record, @Param("example") YtBankInfoExample example);

    int updateByPrimaryKeySelective(YtBankInfo record);

    int updateByPrimaryKey(YtBankInfo record);
}