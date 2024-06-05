package com.pknuErrand.appteam.dto.errand;

import com.pknuErrand.appteam.Enum.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ErrandDistancePaginationRequestVo {
    private double cursor;
    private double latitude;
    private double longitude;
    private int limit;
    private Status status;
}

