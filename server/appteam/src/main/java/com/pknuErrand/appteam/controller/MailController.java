package com.pknuErrand.appteam.controller;

import com.pknuErrand.appteam.service.MailService;
import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.UnsupportedEncodingException;

@Controller
public class MailController {
    private final MailService mailService;
    @Autowired
    MailController(MailService mailService) {
        this.mailService = mailService;
    }

    @GetMapping("/mail")
    public ResponseEntity<String> sendMail(@RequestParam String mail) throws MessagingException, UnsupportedEncodingException {
        mailService.sendMail(mail);
        return ResponseEntity.ok()
                .body("정상적으로 전송 되었습니다.");
    }
    @GetMapping("/mail/check")
    public ResponseEntity<String> checkMailCode(@RequestParam String mail, @RequestParam String code) {
        mailService.checkCode(mail, code);
        return ResponseEntity.ok()
                .body("인증번호 인증 완료.");
    }

    @GetMapping("/mail/memoryStorageClear")
    public String clearExpiredEntryInMemoryStorage() {
        mailService.clearExpiredEntryInMemoryStorage();
        return "인증번호 저장 메모리 스토리지 내 유효시간이 지난 데이터 clear 완료";
    }
}
