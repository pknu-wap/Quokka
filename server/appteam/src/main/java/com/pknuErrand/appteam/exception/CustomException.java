package com.pknuErrand.appteam.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class CustomException extends RuntimeException{

    private final String name;
    private final HttpStatus httpStatus;
    private final String message;
    CustomException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.name = errorCode.name();
        this.httpStatus = errorCode.getHttpStatus();
        this.message = errorCode.getMessage();
    }

    public CustomException(ErrorCode errorCode, String message) {
        super(errorCode.getMessage());
        this.name = errorCode.name();
        this.httpStatus = errorCode.getHttpStatus();
        this.message = message;
    }
}
