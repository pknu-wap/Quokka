package com.pknuErrand.appteam.dto.member;

import jakarta.persistence.Column;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MemberFormDto {

    @Email // 이메일 형태 검사
    @NotNull
    @NotBlank(message = "이메일 주소를 입력해주세요.")
    private String mail; // 이메일

    @NotNull
    @NotBlank(message = "학과를 입력해주세요.")
    private String department; // 학과

    @NotNull
    @NotBlank(message = "이름을 입력해주세요.")
    private String name; // 이름

    @NotNull
    @Size(min = 9, max = 9, message = "학번은 9자리여야합니다.")
    private String id; // 학번

    @NotNull
    // 비밀번호 영어 대,소문자, 숫자, 특수문자
    @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\\d~!@#$%^&*()+|=]{8,20}$", message = "비밀번호는 영문 대문자, 소문자, 숫자, 특수문자를 포함하여 8 ~ 20자로 입력해주세요.")
    private String pw; // 비밀번호

    @NotNull
    // 특수문자 불가, 영어든 한글이든 숫자든 2 ~ 12글자
    @Pattern(regexp = "^[ㄱ-ㅎ가-힣a-z0-9-_]{2,12}$", message = "닉네임은 공백과 특수문자를 제외한 2 ~ 12자리여야 합니다.")
    private String nickname; // 닉네임

}
