package com.mrbt.yeston.admin.service.impl;

import org.activiti.engine.RepositoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrbt.yeston.admin.service.ProcessService;

/**
 * @author Administrator
 *
 */
@Service
public class ProcessServiceImpl implements ProcessService{

	@Autowired
	private RepositoryService repositoryService;

}
