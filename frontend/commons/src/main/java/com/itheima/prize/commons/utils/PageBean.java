package com.itheima.prize.commons.utils;

/**
 * 分页bean
 */

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel("分页信息")
public class PageBean<T> {
    @ApiModelProperty(value = "当前页，1开始")
    private long currentPage = 1;
    @ApiModelProperty(value = "每页条数，默认10")
    private long pageSize = 10;
    @ApiModelProperty(value = "总条数")
    private long totalNum;
    @ApiModelProperty(value = "是否有下一页")
    private Integer isMore;
    @ApiModelProperty(value = "总页数")
    private long totalPage;
    @ApiModelProperty(value = "开始索引")
    private long startIndex;
    @ApiModelProperty(value = "本页数据")
    private List<T> items;

    public PageBean() {
        super();
    }

    public PageBean(long currentPage, long pageSize, long totalNum, List<T> data) {
        super();
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalNum = totalNum;
        this.totalPage = Math.toIntExact((this.totalNum + this.pageSize - 1) / this.pageSize);
        this.startIndex = (this.currentPage-1)*this.pageSize;
        this.isMore = this.currentPage >= this.totalPage?0:1;
        this.items=data;
    }

    public PageBean(Page<T> page) {
        this.currentPage = page.getCurrent();
        this.pageSize = page.getSize();
        this.totalNum = page.getTotal();
        this.totalPage = page.getPages();
        this.startIndex = (this.currentPage-1)*this.pageSize;
        this.isMore = page.hasNext()?1:0;
        this.items=page.getRecords();
    }

    public long getCurrentPage() {
        return currentPage;
    }

    public long getPageSize() {
        return pageSize;
    }

    public long getTotalNum() {
        return totalNum;
    }

    public Integer getIsMore() {
        return isMore;
    }

    public long getTotalPage() {
        return totalPage;
    }

    public long getStartIndex() {
        return startIndex;
    }

    public List<T> getItems() {
        return items;
    }
}