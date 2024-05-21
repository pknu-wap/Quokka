package com.pknuErrand.appteam.dto.statusMessage;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.member.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class StatusMessageRequestDto {
    private Long erranderNo; // 심부름 꾼

 //   private Long errandNo; // 심부름 번호

    private String contents; // 메세지

}
