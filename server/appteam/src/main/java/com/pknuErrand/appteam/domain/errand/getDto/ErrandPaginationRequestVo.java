package com.pknuErrand.appteam.domain.errand.getDto;

import com.pknuErrand.appteam.domain.errand.Sort;
import com.pknuErrand.appteam.domain.errand.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ErrandPaginationRequestVo {
    private Long pk;
    private String cursor;
    private int limit;
    private Status status;
    private Sort sort;
}
