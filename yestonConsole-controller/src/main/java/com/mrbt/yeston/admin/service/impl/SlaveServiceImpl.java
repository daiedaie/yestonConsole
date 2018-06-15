package com.mrbt.yeston.admin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrbt.yeston.admin.commons.annotation.DataSourceChange;
import com.mrbt.yeston.admin.mapper.SlaveMapper;
import com.mrbt.yeston.admin.service.SlaveService;
@Service
public class SlaveServiceImpl implements SlaveService {

    @Autowired
    private SlaveMapper slaveMapper;

    @Override
    @DataSourceChange(slave = true)
    public Integer count() {
        return slaveMapper.count();
    }


}
