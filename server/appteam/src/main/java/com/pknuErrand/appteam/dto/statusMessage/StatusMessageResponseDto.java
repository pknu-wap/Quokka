package com.pknuErrand.appteam.dto.statusMessage;


import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class StatusMessageResponseDto {
    private Member erranderNo; // 심부름 꾼

    private Errand errandNo; // 심부름 번호

    private String contents; // 현황 정보

    private LocalDateTime created;

    public StatusMessageResponseDto(StatusMessage statusMessage) {
        this.erranderNo = statusMessage.getErranderNo();
        this.errandNo = statusMessage.getErrandNo();
        this.contents = statusMessage.getContents();
        this.created = statusMessage.getCreated();
    }
}
