package com.ruoyi.lottery.controller;

import java.math.BigInteger;
import java.security.MessageDigest;
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
import com.ruoyi.lottery.domain.CardUser;
import com.ruoyi.lottery.service.ICardUserService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 会员信息Controller
 * 
 * @author Shawn
 * @date 2023-12-29
 */
@Controller
@RequestMapping("/lottery/user")
public class CardUserController extends BaseController
{
    private String prefix = "lottery/user";

    @Autowired
    private ICardUserService cardUserService;

    @RequiresPermissions("lottery:user:view")
    @GetMapping()
    public String user()
    {
        return prefix + "/user";
    }

    private String md5(String inputStr) {
        BigInteger bigInteger = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] inputData = inputStr.getBytes();
            md.update(inputData);
            bigInteger = new BigInteger(md.digest());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bigInteger.toString(16);
    }
    /**
     * 查询会员信息列表
     */
    @RequiresPermissions("lottery:user:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(CardUser cardUser)
    {
        startPage();
        List<CardUser> list = cardUserService.selectCardUserList(cardUser);
        return getDataTable(list);
    }

    /**
     * 导出会员信息列表
     */
    @RequiresPermissions("lottery:user:export")
    @Log(title = "会员信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(CardUser cardUser)
    {
        List<CardUser> list = cardUserService.selectCardUserList(cardUser);
        ExcelUtil<CardUser> util = new ExcelUtil<CardUser>(CardUser.class);
        return util.exportExcel(list, "会员信息数据");
    }

    /**
     * 新增会员信息
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存会员信息
     */
    @RequiresPermissions("lottery:user:add")
    @Log(title = "会员信息", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(CardUser cardUser)
    {
        CardUser name = new CardUser();
        name.setUname(cardUser.getUname());
        List list = cardUserService.selectCardUserList(name);
        if (list.size() != 0){
            return AjaxResult.error("用户已存在！");
        }
        cardUser.setPasswd(md5(cardUser.getPasswd()));
        return toAjax(cardUserService.insertCardUser(cardUser));
    }

    /**
     * 修改会员信息
     */
    @RequiresPermissions("lottery:user:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap mmap)
    {
        CardUser cardUser = cardUserService.selectCardUserById(id);
        mmap.put("cardUser", cardUser);
        return prefix + "/edit";
    }

    /**
     * 修改保存会员信息
     */
    @RequiresPermissions("lottery:user:edit")
    @Log(title = "会员信息", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(CardUser cardUser)
    {
        return toAjax(cardUserService.updateCardUser(cardUser));
    }

    @RequiresPermissions("lottery:user:edit")
    @Log(title = "会员信息", businessType = BusinessType.UPDATE)
    @PostMapping("/editPwd")
    @ResponseBody
    public AjaxResult editPwd(CardUser cardUser)
    {
        cardUser.setPasswd(md5(cardUser.getPasswd()));
        return toAjax(cardUserService.updateCardUser(cardUser));
    }

    /**
     * 删除会员信息
     */
    @RequiresPermissions("lottery:user:remove")
    @Log(title = "会员信息", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(cardUserService.deleteCardUserByIds(ids));
    }
}
