package com.pknuErrand.appteam.dto.errand;

import com.pknuErrand.appteam.Enum.Status;
import com.pknuErrand.appteam.dto.member.MemberErrandDto;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ErrandDistanceListResponseDto {
   // private MemberErrandDto order = null; // 심부름 시킨사람

    private long errandNo;

    private String createdDate; // 등록한 date

    private String title; // 심부름 제목

    private String destination; // 도착지

    private int reward; // 보수금액

    private Status status; // 상태

    private double distance;
}
