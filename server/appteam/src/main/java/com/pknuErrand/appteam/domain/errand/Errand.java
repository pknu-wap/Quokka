package com.pknuErrand.appteam.domain.errand;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Time;
import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@Entity(name = "errand")
public class Errand {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column
    private long errandNo;

    @Column
    private long orderNo; // 심부름 시킨사람의 pk

    @Column
    private Timestamp createdDate; // 등록한 date

    @Column
    private String title;

    @Column
    private String destination;

    @Column
    private double latitude;

    @Column
    private double longitude;

    @Column
    private Timestamp due; // 몇시까지?

    @Column
    private String detail;

    @Column
    private int reward;

    @Column
    private boolean isCash;

    @Column
    @Enumerated(EnumType.STRING)
    private Status status;

    @Column
    private long erranderNo; // 심부름꾼의 pk

    public Errand(ErrandRequestDto requestDto) {
        this.orderNo = requestDto.getOrderNo();
        this.title = requestDto.getTitle();
        this.destination = requestDto.getDestination();
        this.latitude = requestDto.getLatitude();
        this.longitude = requestDto.getLongitude();
        this.due = requestDto.getDue();
        this.detail = requestDto.getDetail();
        this.reward = requestDto.getReward();
        this.isCash = requestDto.isCash();
        this.status = requestDto.getStatus();
        this.erranderNo = requestDto.getErranderNo();
    }
}
