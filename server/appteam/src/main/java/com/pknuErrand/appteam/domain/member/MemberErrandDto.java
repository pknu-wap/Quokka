package com.pknuErrand.appteam.domain.member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberErrandDto {

    private long errandNo;

    private String nickname;

    private double score;

}
