package com.ruoyi.lottery.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysDictData;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.ISysDictDataService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

/**
 * 会员等级管理Controller
 * 
 * @author Shawn
 * @date 2024-01-03
 */
@Controller("userLevelDictController")
@RequestMapping("/lottery/data")
public class SysDictDataController extends BaseController
{
    private String prefix = "lottery/data";

    @Autowired
    private ISysDictDataService sysDictDataService;

    @RequiresPermissions("lottery:data:view")
    @GetMapping()
    public String data()
    {
        return prefix + "/data";
    }

    /**
     * 查询会员等级管理列表
     */
    @RequiresPermissions("lottery:data:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(SysDictData sysDictData)
    {
        sysDictData.setDictType("card_user_level");
        startPage();
        List<SysDictData> list = sysDictDataService.selectDictDataList(sysDictData);
        return getDataTable(list);
    }

    /**
     * 导出会员等级管理列表
     */
    @RequiresPermissions("lottery:data:export")
    @Log(title = "会员等级管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(SysDictData sysDictData)
    {
        List<SysDictData> list = sysDictDataService.selectDictDataList(sysDictData);
        ExcelUtil<SysDictData> util = new ExcelUtil<SysDictData>(SysDictData.class);
        return util.exportExcel(list, "会员等级管理数据");
    }

    /**
     * 新增会员等级管理
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存会员等级管理
     */
    @RequiresPermissions("lottery:data:add")
    @Log(title = "会员等级管理", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(SysDictData sysDictData)
    {
        sysDictData.setDictType("card_user_level");
        return toAjax(sysDictDataService.insertDictData(sysDictData));
    }

    /**
     * 修改会员等级管理
     */
    @RequiresPermissions("lottery:data:edit")
    @GetMapping("/edit/{dictCode}")
    public String edit(@PathVariable("dictCode") Long dictCode, ModelMap mmap)
    {
        SysDictData sysDictData = sysDictDataService.selectDictDataById(dictCode);
        mmap.put("sysDictData", sysDictData);
        return prefix + "/edit";
    }

    /**
     * 修改保存会员等级管理
     */
    @RequiresPermissions("lottery:data:edit")
    @Log(title = "会员等级管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(SysDictData sysDictData)
    {
        sysDictData.setDictType("card_user_level");
        return toAjax(sysDictDataService.updateDictData(sysDictData));
    }

    /**
     * 删除会员等级管理
     */
    @RequiresPermissions("lottery:data:remove")
    @Log(title = "会员等级管理", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        sysDictDataService.deleteDictDataByIds(ids);
        return toAjax(true);
    }
}
