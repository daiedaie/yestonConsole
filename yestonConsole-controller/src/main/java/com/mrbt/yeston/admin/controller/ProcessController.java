package com.mrbt.yeston.admin.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipInputStream;

import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.admin.model.ProcessDefinationVo;

@Controller
@RequestMapping("/process")
public class ProcessController extends BaseController{

	@Autowired
	private RepositoryService repositoryService;
	
	/**
	 * 查看流程图
	 * @return
	 */
	@RequestMapping("viewImg")
	public void viewImg(String id,String imgName,HttpServletResponse response){
		try {
			InputStream inputStream = repositoryService.getResourceAsStream(id, imgName);
			response.setContentType("image/png");
			IOUtils.copy(inputStream, response.getOutputStream());
		} catch (Exception e) {}
	}
	
	@RequestMapping("dataGrid")
	public @ResponseBody Object dataGrid(Integer page,Integer rows){
		try {
			PageInfo<ProcessDefinationVo> pageInfo = new PageInfo<>(page, rows);
			ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
			List<ProcessDefinition> list = query.listPage((page-1)*rows, rows);
			List<ProcessDefinationVo> data = new ArrayList<>();
			if(list != null && list.size() > 0){
				ProcessDefinationVo vo;
				for (ProcessDefinition processDefinition : list) {
					vo = new ProcessDefinationVo();
					vo.setId(processDefinition.getId());
					vo.setKey(processDefinition.getKey());
					vo.setName(processDefinition.getName());
					vo.setDeploymentId(processDefinition.getDeploymentId());
					vo.setResourceFile(processDefinition.getResourceName());
					vo.setResourceImg(processDefinition.getDiagramResourceName());
					vo.setVersion(processDefinition.getVersion());
					data.add(vo);
				}
			}
			pageInfo.setRows(data);
			pageInfo.setTotal((int)query.count());
			return pageInfo;
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	@RequestMapping("deleteProcess")
	public  @ResponseBody Object deleteProcess(String deploymentId){
		try {
			repositoryService.deleteDeployment(deploymentId,true);
			return renderSuccess();
		} catch (Exception e) {
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	@RequestMapping("manager")
	public String manager(){
		return "/process/processManager";
	}
	
	@RequestMapping("deployPage")
	public String deployPage(){
		return "/process/processDeploy";
	}
	
	@RequestMapping("/deploy")
	public @ResponseBody Object deploy(@RequestParam("deployFile") MultipartFile deployFile){
		try {
			repositoryService.createDeployment().name("车贷流程").addZipInputStream(
					new ZipInputStream(deployFile.getInputStream())).deploy();
			return renderSuccess();
		} catch (IOException e) {
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
}
