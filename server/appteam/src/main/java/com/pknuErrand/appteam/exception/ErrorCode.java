package com.pknuErrand.appteam.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ErrorCode {


    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "사용자를 찾을 수 없습니다."),
    ERRAND_NOT_FOUND(HttpStatus.NOT_FOUND, "심부름을 찾을 수 없습니다."),
    UNAUTHORIZED_ACCESS(HttpStatus.FORBIDDEN, "접근 권한이 없습니다."),
    RESTRICT_CONTENT_ACCESS(HttpStatus.BAD_REQUEST, "변경할 수 업습니다.");


    private final HttpStatus httpStatus;
    private final String message;
}
