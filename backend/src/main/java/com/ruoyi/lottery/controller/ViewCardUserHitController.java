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
import com.ruoyi.lottery.domain.ViewCardUserHit;
import com.ruoyi.lottery.service.IViewCardUserHitService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 中奖用户详情Controller
 * 
 * @author Shawn
 * @date 2024-01-02
 */
@Controller
@RequestMapping("/lottery/hit")
public class ViewCardUserHitController extends BaseController
{
    private String prefix = "lottery/hit";

    @Autowired
    private IViewCardUserHitService viewCardUserHitService;

    @RequiresPermissions("lottery:hit:view")
    @GetMapping()
    public String hit()
    {
        return prefix + "/hit";
    }

    /**
     * 查询中奖用户详情列表
     */
    @RequiresPermissions("lottery:hit:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(ViewCardUserHit viewCardUserHit)
    {
        startPage();
        List<ViewCardUserHit> list = viewCardUserHitService.selectViewCardUserHitList(viewCardUserHit);
        return getDataTable(list);
    }

    /**
     * 导出中奖用户详情列表
     */
    @RequiresPermissions("lottery:hit:export")
    @Log(title = "中奖用户详情", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ViewCardUserHit viewCardUserHit)
    {
        List<ViewCardUserHit> list = viewCardUserHitService.selectViewCardUserHitList(viewCardUserHit);
        ExcelUtil<ViewCardUserHit> util = new ExcelUtil<ViewCardUserHit>(ViewCardUserHit.class);
        return util.exportExcel(list, "中奖用户详情数据");
    }

    /**
     * 新增中奖用户详情
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存中奖用户详情
     */
    @RequiresPermissions("lottery:hit:add")
    @Log(title = "中奖用户详情", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(ViewCardUserHit viewCardUserHit)
    {
        return toAjax(viewCardUserHitService.insertViewCardUserHit(viewCardUserHit));
    }

    /**
     * 修改中奖用户详情
     */
    @RequiresPermissions("lottery:hit:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Integer id, ModelMap mmap)
    {
        ViewCardUserHit viewCardUserHit = viewCardUserHitService.selectViewCardUserHitById(id);
        mmap.put("viewCardUserHit", viewCardUserHit);
        return prefix + "/edit";
    }

    /**
     * 修改保存中奖用户详情
     */
    @RequiresPermissions("lottery:hit:edit")
    @Log(title = "中奖用户详情", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(ViewCardUserHit viewCardUserHit)
    {
        return toAjax(viewCardUserHitService.updateViewCardUserHit(viewCardUserHit));
    }

    /**
     * 删除中奖用户详情
     */
    @RequiresPermissions("lottery:hit:remove")
    @Log(title = "中奖用户详情", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(viewCardUserHitService.deleteViewCardUserHitByIds(ids));
    }
}
