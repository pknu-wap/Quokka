package com.pknuErrand.appteam.domain.member;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@RequiredArgsConstructor
@NoArgsConstructor
public class Member {

    @Id
    @Column(unique = true)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long memberNo; // 사용자 고유 번호

    @NonNull
    @Column(unique = true)
    private String mail; // 학교 메일

    @NonNull
    private String department; // 학과

    @NonNull
    private String name; // 이름

    @NonNull
    @Column(unique = true)
    private Long id; // 학번 == 아이디

    @NonNull
    private String pw; // 비밀번호

    @NonNull
    @Column(unique = true)
    private String nickname; // 닉네임

    @NonNull
    @Column
    private double score; // 평점 지수

    @NonNull
    @Column
    private String role; // Security 사용을 위한 역할

}
