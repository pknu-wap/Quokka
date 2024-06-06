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
    private String contents; // 현황 정보

    private LocalDateTime created;

    public StatusMessageResponseDto(StatusMessage statusMessage) {
        this.contents = statusMessage.getContents();
        this.created = statusMessage.getCreated();
    }
}
