package com.itheima.prize.commons.utils;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@ApiModel("响应报文")
public class ApiResult<T> {
    @ApiModelProperty(value = "状态码（-1=异常，0=业务不成功，1=业务成功）",required = true)
    private int code;
    @ApiModelProperty(value = "信息",required = true)
    private String msg;
    @ApiModelProperty(value = "数据")
    private Object data;
    @ApiModelProperty(value = "服务器时间")
    @DateTimeFormat(pattern="yyyy/MM/dd hh:mm:ss")
    @JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss")
    private Date now = new Date();

    public ApiResult(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public Date getNow() {
        return now;
    }

    public void setNow(Date now) {
        this.now = now;
    }
}
