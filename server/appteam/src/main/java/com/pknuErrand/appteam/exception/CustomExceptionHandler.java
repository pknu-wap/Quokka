package com.pknuErrand.appteam.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<ExceptionResponseDto> customExceptionHandler(CustomException e) {

        log.warn("{} / {} / {}\n\n", e.getCode(), e.getHttpStatus(), e.getMessage());

        return ResponseEntity.status(e.getHttpStatus())
                .body(ExceptionResponseDto.builder()
                        .code(e.getCode())
                        .httpStatus(e.getHttpStatus())
                        .message(e.getMessage())
                        .build());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ExceptionResponseDto> validExceptionHandler(MethodArgumentNotValidException e) {

        FieldError fieldError = e.getBindingResult().getFieldError();
        String message = fieldError.getDefaultMessage() + " / " + fieldError.getField() + " = " + fieldError.getRejectedValue();

        log.warn("Valid Exception / {}\n\n", message);


        return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                .body(ExceptionResponseDto.builder()
                        .code("Valid Exception")
                        .httpStatus(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                        .message(message)
                        .build());
    }

    @ExceptionHandler
    public ResponseEntity<?> AnotherExceptionHandler(Exception e) {

        log.error("Exception / {}", e.getMessage());
        e.printStackTrace();

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(ExceptionResponseDto.builder()
                        .code(e.toString().split(":")[0])
                        .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                        .message(e.getMessage() + "\n계속 발생하면 백엔드팀에 문의하셈")
                        .build());
    }

}
