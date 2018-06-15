package com.mrbt.yeston.web.mapper;

import com.mrbt.yeston.web.model.YtBankAccountType;
import com.mrbt.yeston.web.model.YtBankAccountTypeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface YtBankAccountTypeMapper {
    int countByExample(YtBankAccountTypeExample example);

    int deleteByExample(YtBankAccountTypeExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(YtBankAccountType record);

    int insertSelective(YtBankAccountType record);

    List<YtBankAccountType> selectByExample(YtBankAccountTypeExample example);

    YtBankAccountType selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") YtBankAccountType record, @Param("example") YtBankAccountTypeExample example);

    int updateByExample(@Param("record") YtBankAccountType record, @Param("example") YtBankAccountTypeExample example);

    int updateByPrimaryKeySelective(YtBankAccountType record);

    int updateByPrimaryKey(YtBankAccountType record);
}