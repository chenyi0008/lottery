package com.chenyi.prize.commons.exception;

import lombok.Data;

/**
 * @Description
 * @Author chenyi0008
 * @Date 2024/4/8
 */
@Data
public class BusinessException extends Exception{

    private String message;

    public BusinessException(String msg) {
        super(msg);
        this.message = msg;
    }
}
