package com.ruoyi.lottery.controller;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.lottery.domain.ViewGameCurinfo;
import com.ruoyi.lottery.service.IViewGameCurinfoService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 活动中奖统计Controller
 * 
 * @author Shawn
 * @date 2024-01-02
 */
@Controller
@RequestMapping("/lottery/curinfo")
public class ViewGameCurinfoController extends BaseController
{
    private String prefix = "lottery/curinfo";

    @Autowired
    private IViewGameCurinfoService viewGameCurinfoService;

    @RequiresPermissions("lottery:curinfo:view")
    @GetMapping()
    public String curinfo()
    {
        return prefix + "/curinfo";
    }

    /**
     * 查询活动中奖统计列表
     */
    @RequiresPermissions("lottery:curinfo:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(ViewGameCurinfo viewGameCurinfo)
    {
        startPage();
        List<ViewGameCurinfo> list = viewGameCurinfoService.selectViewGameCurinfoList(viewGameCurinfo);
        return getDataTable(list);
    }

    /**
     * 导出活动中奖统计列表
     */
    @RequiresPermissions("lottery:curinfo:export")
    @Log(title = "活动中奖统计", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ViewGameCurinfo viewGameCurinfo)
    {
        List<ViewGameCurinfo> list = viewGameCurinfoService.selectViewGameCurinfoList(viewGameCurinfo);
        ExcelUtil<ViewGameCurinfo> util = new ExcelUtil<ViewGameCurinfo>(ViewGameCurinfo.class);
        return util.exportExcel(list, "活动中奖统计数据");
    }

    /**
     * 新增活动中奖统计
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存活动中奖统计
     */
    @RequiresPermissions("lottery:curinfo:add")
    @Log(title = "活动中奖统计", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(ViewGameCurinfo viewGameCurinfo)
    {
        return toAjax(viewGameCurinfoService.insertViewGameCurinfo(viewGameCurinfo));
    }

    /**
     * 修改活动中奖统计
     */
    @RequiresPermissions("lottery:curinfo:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Integer id, ModelMap mmap)
    {
        ViewGameCurinfo viewGameCurinfo = viewGameCurinfoService.selectViewGameCurinfoById(id);
        mmap.put("viewGameCurinfo", viewGameCurinfo);
        return prefix + "/edit";
    }

    /**
     * 修改保存活动中奖统计
     */
    @RequiresPermissions("lottery:curinfo:edit")
    @Log(title = "活动中奖统计", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(ViewGameCurinfo viewGameCurinfo)
    {
        return toAjax(viewGameCurinfoService.updateViewGameCurinfo(viewGameCurinfo));
    }

    /**
     * 删除活动中奖统计
     */
    @RequiresPermissions("lottery:curinfo:remove")
    @Log(title = "活动中奖统计", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(viewGameCurinfoService.deleteViewGameCurinfoByIds(ids));
    }
}
