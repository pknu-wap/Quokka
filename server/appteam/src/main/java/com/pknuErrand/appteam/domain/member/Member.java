package com.pknuErrand.appteam.domain.member;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;

@Getter
@Entity(name = "member")
public class Member {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private long memberNo;
}
