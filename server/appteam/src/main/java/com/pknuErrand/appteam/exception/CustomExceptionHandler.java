package com.pknuErrand.appteam.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<ExceptionResponseDto> customExceptionHandler(CustomException e) {

        log.error("{} / {} / {}\n\n", e.getName(), e.getHttpStatus(), e.getMessage());

        return ResponseEntity.status(e.getHttpStatus())
                .body(ExceptionResponseDto.builder()
                        .name(e.getName())
                        .httpStatus(e.getHttpStatus())
                        .message(e.getMessage())
                        .build());
    }

    @ExceptionHandler
    public ResponseEntity<?> AnotherExceptionHandler(Exception e) {

        log.error("Exception / {}", e.getMessage());
        e.printStackTrace();

        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(ExceptionResponseDto.builder()
                        .name(e.toString().split(":")[0])
                        .httpStatus(HttpStatus.BAD_REQUEST)
                        .message(e.getMessage())
                        .build());
    }

}
