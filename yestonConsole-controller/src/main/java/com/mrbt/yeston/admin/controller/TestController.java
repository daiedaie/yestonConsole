package com.mrbt.yeston.admin.controller;

import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.service.SlaveService;

import org.activiti.engine.RepositoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @description：测试Controller
 * @author：ruochen.yu
 * @date：2016/10/1 14:51
 */
@Controller
@RequestMapping("/test")
public class TestController extends BaseController {

    @Autowired
    private SlaveService slaveService;

    /**
     * 主重库测试
     * @param model
     * @return
     */
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public String page(Model model) {
        return "test";
    }
    
    @RequestMapping(value = "/slave", method = RequestMethod.GET)
    public String slave(Model model) {
        Integer count = slaveService.count();
        model.addAttribute("count", count);
        return "admin/test";
    }

    /**
     * 图标测试
     * @return
     */
    @RequestMapping(value = "/dataGrid", method = RequestMethod.GET)
    public String dataGrid() {
        return "admin/test";
    }

}
