package com.pknuErrand.appteam.domain.member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class MemberUserDetailsDto {
    private String mail;
    private String role;
    private String pw;
}
