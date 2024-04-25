package com.pknuErrand.appteam.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<ExceptionResponseDto> exceptionHandler(CustomException e) {

        log.warn("{} \n {} {}", e.getName(), e.getHttpStatus(), e.getMessage());

        ExceptionResponseDto exceptionResponseDto = ExceptionResponseDto.builder()
                .name(e.getName())
                .httpStatus(e.getHttpStatus())
                .message(e.getMessage())
                .build();
        return exceptionResponseDto.buildEntity();
    }
}
