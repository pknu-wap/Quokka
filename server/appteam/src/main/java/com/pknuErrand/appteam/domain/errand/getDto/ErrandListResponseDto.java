package com.pknuErrand.appteam.domain.errand.getDto;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.Status;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.member.MemberErrandDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ErrandListResponseDto { // from Entity
    private MemberErrandDto order; // 심부름 시킨사람

    private String createdDate; // 등록한 date

    private String title; // 심부름 제목

    private String destination; // 도착지

    private int reward; // 보수금액

    private Status status; // 상태

}
