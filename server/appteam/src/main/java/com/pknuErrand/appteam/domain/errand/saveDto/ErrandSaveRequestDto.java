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
    
    /**
     *  게시글 등록하는 member의 정보는 jwt에서 추출
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
