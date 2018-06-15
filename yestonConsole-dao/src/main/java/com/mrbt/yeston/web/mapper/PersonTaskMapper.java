package com.mrbt.yeston.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mrbt.yeston.web.vo.YtBankInfoVo;

public interface PersonTaskMapper {

	String findUserNameById(Integer uid);

	List<Integer> findBranchCheckUserByBusinessKey(@Param("carLoanId") String carLoanId,@Param("uId") Long uId);

	List<Integer> findCooperateFinanceByCooperateId(String cooperateId);

	List<YtBankInfoVo> findBankInfoByCoopearateId(String coopearateId);

	String findCoopearateIdByCarLoanId(String carLoanId);

	List<YtBankInfoVo> findBankInfo();
}
