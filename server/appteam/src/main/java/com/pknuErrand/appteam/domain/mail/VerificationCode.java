package com.pknuErrand.appteam.domain.mail;

import lombok.Getter;

import java.time.LocalDateTime;
import java.util.Random;

@Getter
public class VerificationCode {

    private final String code;
    private final LocalDateTime expiredTime;
    public VerificationCode() {
        code = generateCode();
        expiredTime = LocalDateTime.now().plusMinutes(5);
    }

    private String generateCode() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++)
            sb.append(String.valueOf(random.nextInt(10)));
        return sb.toString();
    }
}
