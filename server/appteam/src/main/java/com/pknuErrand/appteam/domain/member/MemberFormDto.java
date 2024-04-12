package com.pknuErrand.appteam.domain.member;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MemberFormDto {
    private long memberNo;

    private String mail;

    private String department;

    private String name;

    private long id;

    private String pw;

    private String nickname;

    private double score;

    private String role;

}
