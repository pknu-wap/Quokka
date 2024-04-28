package com.pknuErrand.appteam.domain.member;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
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

    @Email
    @NonNull
    @Column(unique = true)
    @NotBlank(message = "이메일 주소를 입력해주세요.")
    private String mail; // 학교 메일

    @NonNull
    private String department; // 학과

    @NonNull
    private String name; // 이름

    @NonNull
    @Column(unique = true)
    private String id; // 학번 == 아이디

    @NonNull
    @NotBlank(message = "비밀번호를 입력하세요.")
    @Size(min = 8, max = 20, message = "비밀번호는 8자 이상 20자 이하로 입력해주세요.")
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
