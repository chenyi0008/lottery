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
import com.ruoyi.lottery.domain.CardGame;
import com.ruoyi.lottery.service.ICardGameService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 活动管理Controller
 * 
 * @author Shawn
 * @date 2023-12-28
 */
@Controller
@RequestMapping("/lottery/game")
public class CardGameController extends BaseController
{
    private String prefix = "lottery/game";

    @Autowired
    private ICardGameService cardGameService;

    @RequiresPermissions("lottery:game:view")
    @GetMapping()
    public String game()
    {
        return prefix + "/game";
    }

    /**
     * 查询活动管理列表
     */
    @RequiresPermissions("lottery:game:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(CardGame cardGame)
    {
        startPage();
        List<CardGame> list = cardGameService.selectCardGameList(cardGame);
        return getDataTable(list);
    }

    /**
     * 导出活动管理列表
     */
    @RequiresPermissions("lottery:game:export")
    @Log(title = "活动管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(CardGame cardGame)
    {
        List<CardGame> list = cardGameService.selectCardGameList(cardGame);
        ExcelUtil<CardGame> util = new ExcelUtil<CardGame>(CardGame.class);
        return util.exportExcel(list, "活动管理数据");
    }

    /**
     * 新增活动管理
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存活动管理
     */
    @RequiresPermissions("lottery:game:add")
    @Log(title = "活动管理", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(CardGame cardGame)
    {
        return toAjax(cardGameService.insertCardGame(cardGame));
    }

    /**
     * 修改活动管理
     */
    @RequiresPermissions("lottery:game:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Integer id, ModelMap mmap)
    {
        CardGame cardGame = cardGameService.selectCardGameById(id);
        mmap.put("cardGame", cardGame);
        return prefix + "/edit";
    }

    /**
     * 修改保存活动管理
     */
    @RequiresPermissions("lottery:game:edit")
    @Log(title = "活动管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(CardGame cardGame)
    {
        return toAjax(cardGameService.updateCardGame(cardGame));
    }

    /**
     * 删除活动管理
     */
    @RequiresPermissions("lottery:game:remove")
    @Log(title = "活动管理", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(cardGameService.deleteCardGameByIds(ids));
    }
}
