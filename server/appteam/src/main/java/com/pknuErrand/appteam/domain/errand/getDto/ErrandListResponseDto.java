package com.pknuErrand.appteam.domain.errand.defaultDto;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.Status;
import com.pknuErrand.appteam.domain.member.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ErrandListResponseDto { // from Entity
    private Member orderNo; // 심부름 시킨사람

    private Timestamp createdDate; // 등록한 date

    private String title; // 심부름 제목

    private String destination; // 도착지

    private int reward; // 보수금액

    private Status status; // 상태

    public ErrandResponseDto(Errand errand) {
        this.orderNo = errand.getOrderNo();
        this.createdDate = errand.getCreatedDate();
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
