package com.chenyi.prize.commons.exception;

import com.chenyi.prize.commons.utils.ApiResult;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

/**
 * @Description
 * @Author chenyi0008
 * @Date 2024/4/8
 */
@ControllerAdvice
@ResponseBody
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public ApiResult handleBusinessException(BusinessException ex, HttpServletResponse response) {
        // 处理业务异常
        System.out.println(ex.getMessage());
        String errorMessage = ex.getMessage();
        // 可以根据具体情况进行日志记录、返回特定的错误码等操作
        response.setStatus(HttpStatus.TOO_MANY_REQUESTS.value());
        return new ApiResult(-1, errorMessage, null);
    }

//    @ExceptionHandler(Exception.class)
//    public ResponseEntity<String> handleException(Exception ex) {
//        // 处理其他未被捕获的异常
//        String errorMessage = "发生了未知错误";
//        // 可以根据具体情况进行日志记录、返回特定的错误码等操作
//        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
//    }
}