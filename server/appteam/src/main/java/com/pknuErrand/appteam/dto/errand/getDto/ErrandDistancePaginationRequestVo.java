package com.pknuErrand.appteam.dto.errand.getDto;

import com.pknuErrand.appteam.Enum.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ErrandDistancePaginationRequestVo {
    private Long pk;
    private double latitude;
    private double longitude;
    private int limit;
    private Status status;
}

