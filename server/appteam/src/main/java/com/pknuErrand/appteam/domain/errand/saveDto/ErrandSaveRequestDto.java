package com.pknuErrand.appteam.domain.errand.saveDto;

import com.pknuErrand.appteam.domain.errand.Status;
import com.pknuErrand.appteam.domain.member.Member;
import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Getter
public class ErrandSaveRequestDto { // to Entity

    private Long orderNo; // 심부름 시킨사람 pk
    /**
     *  pk 를 통해 가져온다.
     */

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

    /**
     *  request 받을 때 (save하려고 정보를 받을 때) 담당자 정보는 가져올 필요가 없다.
     */
}
