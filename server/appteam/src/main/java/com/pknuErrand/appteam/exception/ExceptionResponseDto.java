package com.pknuErrand.appteam.exception;

import lombok.Builder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@Builder
public class ExceptionResponseDto {
    private final String name;
    private final HttpStatus httpStatus;
    private final String message;

    public ResponseEntity<ExceptionResponseDto> buildEntity() {
        return ResponseEntity.status(httpStatus)
                .body(this);
    }
}
