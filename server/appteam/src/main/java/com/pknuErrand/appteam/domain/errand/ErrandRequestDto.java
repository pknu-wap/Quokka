package com.pknuErrand.appteam.domain.errand;

import com.pknuErrand.appteam.domain.member.Member;
import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Getter
public class ErrandRequestDto { // to Entity

    private Member orderNo; // 심부름 시킨사람

    private Timestamp createdDate; // 등록한 date

    private String title;

    private String destination;

    private double latitude;

    private double longitude;

    private Timestamp due; // 몇시까지?

    private String detail;

    private int reward;

    private boolean isCash;

    private Status status;

    private Member erranderNo; // 심부름꾼

}
