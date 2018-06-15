package com.mrbt.yeston.listener;

import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;

import com.mrbt.yeston.web.mapper.TaskListenerMapper;
import com.mrbt.yeston.web.utils.SpringContextHolder;

/**
 * @author 罗鑫
 * Date 2017年3月15日
 */
public class AdminListener implements TaskListener {
	private static final long serialVersionUID = -6366133604099364792L;

	@Override
	public void notify(DelegateTask delegateTask) {
		TaskListenerMapper taskListenerMapper = SpringContextHolder.getBean(TaskListenerMapper.class);
		List<Integer> userList = taskListenerMapper.findAdminUser();
		List<String> candidateUsers = new ArrayList<>();
		for (Integer u : userList) {
			candidateUsers.add(String.valueOf(u));
		}
		delegateTask.addCandidateUsers(candidateUsers);
	}
}