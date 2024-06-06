package com.pknuErrand.appteam.dto.errand;

import com.pknuErrand.appteam.Enum.Status;
import com.pknuErrand.appteam.dto.member.MemberErrandDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
@Builder
public class ErrandDetailResponseDto {
    private MemberErrandDto order; // 심부름 시킨사람

    private long errandNo; // 심부름 번호

    private String createdDate; // 등록한 date

    private String title; // 심부름 제목

    private String destination; // 도착지

    private double latitude; // 위도

    private double longitude; // 경도

    private String due; // 몇시까지?

    private String detail; // 상세 내용

    private int reward; // 보수금액

    private Boolean isCash; // 현금 계좌이체 선택

    private Status status; // 상태

    private Boolean isMyErrand; // 본인 게시물인가?
}
