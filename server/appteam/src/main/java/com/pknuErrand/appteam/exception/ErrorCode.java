package com.pknuErrand.appteam.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ErrorCode {


    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "사용자를 찾을 수 없습니다."),
    ERRAND_NOT_FOUND(HttpStatus.NOT_FOUND, "심부름을 찾을 수 없습니다."),
    UNAUTHORIZED_ACCESS(HttpStatus.UNAUTHORIZED, "접근 권한이 없습니다."),
    RESTRICT_CONTENT_ACCESS(HttpStatus.BAD_REQUEST, "변경할 수 업습니다."),

    DUPLICATE_DATA(HttpStatus.BAD_REQUEST, "중복된 데이터입니다."),
    INVALID_FORMAT(HttpStatus.BAD_REQUEST, "양식에 어긋납니다."),
    INVALID_VALUE(HttpStatus.BAD_REQUEST, "값이 틀립니다."),
    EXPIRED_TIME(HttpStatus.BAD_REQUEST, "시간이 초과되었습니다.");

    private final HttpStatus httpStatus;
    private final String message;
}
