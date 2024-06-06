package com.pknuErrand.appteam.dto.errand;

import com.pknuErrand.appteam.Enum.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ErrandPaginationRequestVo {
    private Long pk;
    private String cursor;
    private int limit;
    private Status status;
}
