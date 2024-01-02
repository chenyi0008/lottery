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
import com.ruoyi.lottery.domain.CardProduct;
import com.ruoyi.lottery.service.ICardProductService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 奖品管理Controller
 * 
 * @author Shawn
 * @date 2023-12-28
 */
@Controller
@RequestMapping("/lottery/product")
public class CardProductController extends BaseController
{
    private String prefix = "lottery/product";

    @Autowired
    private ICardProductService cardProductService;

    @RequiresPermissions("lottery:product:view")
    @GetMapping()
    public String product()
    {
        return prefix + "/product";
    }

    /**
     * 查询奖品管理列表
     */
    @RequiresPermissions("lottery:product:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(CardProduct cardProduct)
    {
        startPage();
        List<CardProduct> list = cardProductService.selectCardProductList(cardProduct);
        return getDataTable(list);
    }

    /**
     * 导出奖品管理列表
     */
    @RequiresPermissions("lottery:product:export")
    @Log(title = "奖品管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(CardProduct cardProduct)
    {
        List<CardProduct> list = cardProductService.selectCardProductList(cardProduct);
        ExcelUtil<CardProduct> util = new ExcelUtil<CardProduct>(CardProduct.class);
        return util.exportExcel(list, "奖品管理数据");
    }

    /**
     * 新增奖品管理
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存奖品管理
     */
    @RequiresPermissions("lottery:product:add")
    @Log(title = "奖品管理", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(CardProduct cardProduct)
    {
        return toAjax(cardProductService.insertCardProduct(cardProduct));
    }

    /**
     * 修改奖品管理
     */
    @RequiresPermissions("lottery:product:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Integer id, ModelMap mmap)
    {
        CardProduct cardProduct = cardProductService.selectCardProductById(id);
        mmap.put("cardProduct", cardProduct);
        return prefix + "/edit";
    }

    /**
     * 修改保存奖品管理
     */
    @RequiresPermissions("lottery:product:edit")
    @Log(title = "奖品管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(CardProduct cardProduct)
    {
        return toAjax(cardProductService.updateCardProduct(cardProduct));
    }

    /**
     * 删除奖品管理
     */
    @RequiresPermissions("lottery:product:remove")
    @Log(title = "奖品管理", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(cardProductService.deleteCardProductByIds(ids));
    }
}
