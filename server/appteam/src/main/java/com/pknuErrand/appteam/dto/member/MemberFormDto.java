package com.pknuErrand.appteam.dto.member;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MemberFormDto {

    private String mail; // 이메일

    private String department; // 학과

    private String name; // 이름

    private String id; // 학번

    private String pw; // 비밀번호

    private String nickname; // 닉네임

}
