package com.pknuErrand.appteam.domain.errand.getDto;

import com.pknuErrand.appteam.domain.errand.Status;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.member.MemberErrandDto;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class ErrandDetailResponseDto {
    private MemberErrandDto order; // 심부름 시킨사람

    private Timestamp createdDate; // 등록한 date

    private String title; // 심부름 제목

    private String destination; // 도착지

    private double latitude; // 위도

    private double longitude; // 경도

    private Timestamp due; // 몇시까지?

    private String detail; // 상세 내용

    private int reward; // 보수금액

    private boolean isCash; // 현금 계좌이체 선택

    private Status status; // 상태
}
