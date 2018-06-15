package com.mrbt.yeston.listener;

import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.stereotype.Component;

import com.mrbt.yeston.web.mapper.TaskListenerMapper;
import com.mrbt.yeston.web.utils.SpringContextHolder;

/**
 * @author 罗鑫
 * Date 2017年3月15日
 */
@Component
public class HeadquarterProductListener implements TaskListener {
	private static final long serialVersionUID = -5407730333817588349L;
	
	@Override
	public void notify(DelegateTask delegateTask) {
		TaskListenerMapper taskListenerMapper = SpringContextHolder.getBean(TaskListenerMapper.class);
		List<Integer> userList = taskListenerMapper.findHeadquarterProduct();
		List<String> candidateUsers = new ArrayList<>();
		for (Integer u : userList) {
			candidateUsers.add(String.valueOf(u));
		}
		delegateTask.addCandidateUsers(candidateUsers);
	}
}
