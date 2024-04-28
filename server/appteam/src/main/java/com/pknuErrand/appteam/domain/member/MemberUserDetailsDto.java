package com.pknuErrand.appteam.domain.member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class MemberUserDetailsDto {

    private String id;

    private String role;

    private String pw;

}
