package com.pknuErrand.appteam.domain.errand;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Getter
public class ErrandRequestDto { // to Entity

    private long orderNo; // 심부름 시킨사람의 pk

    private String title;

    private String destination;

    private double latitude;

    private double longitude;

    private Timestamp due; // 몇시까지?

    private String detail;

    private int reward;

    private boolean isCash;

    private Status status;

    private long erranderNo; // 심부름꾼의 pk

}
