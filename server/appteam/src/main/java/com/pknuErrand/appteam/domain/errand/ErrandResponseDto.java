package com.pknuErrand.appteam.domain.errand;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ErrandResponseDto { // from Entity
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

    public ErrandResponseDto(Errand errand) {
        this.orderNo = errand.getOrderNo();
        this.title = errand.getTitle();
        this.destination = errand.getDestination();
        this.latitude = errand.getLatitude();
        this.longitude = errand.getLongitude();
        this.due = errand.getDue();
        this.detail = errand.getDetail();
        this.reward = errand.getReward();
        this.isCash = errand.isCash();
        this.status = errand.getStatus();
        this.erranderNo = errand.getErranderNo();
    }

}
