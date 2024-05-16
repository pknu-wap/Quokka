package com.pknuErrand.appteam.exception;

import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@Getter
@Builder
public class ExceptionResponseDto {
    private final String code;
    private final HttpStatus httpStatus;
    private final String message;

}
