package com.pknuErrand.appteam.controller;

import com.pknuErrand.appteam.dto.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.exception.ExceptionResponseDto;
import com.pknuErrand.appteam.service.MailService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.UnsupportedEncodingException;

@Tag(name = "Mail", description = "Mail 인증 관련 API")
@Controller
public class MailController {
    private final MailService mailService;
    @Autowired
    MailController(MailService mailService) {
        this.mailService = mailService;
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "메일 전송 성공", content = @Content(mediaType = "정상적으로 전송 되었습니다.")) ,
            @ApiResponse(responseCode = "400\nDUPLICATE_DATA", description = "이미 존재하는 메일", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))),
            @ApiResponse(responseCode = "415\nINVALID_FORMAT", description = "메일 주소 format 잘못됨", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class)))
    })
    @Operation(summary = "메일로 인증번호 전송" , description = "메일로 인증번호 전송")
    @GetMapping("/mail")
    public ResponseEntity<String> sendMail(@RequestParam String mail) throws MessagingException, UnsupportedEncodingException {
        mailService.sendMail(mail);
        return ResponseEntity.ok()
                .body("정상적으로 전송 되었습니다.");
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "인증번호 인증 성공", content = @Content(mediaType = "인증번호 인증 완료.")) ,
            @ApiResponse(responseCode = "400\nINVALID_VALUE", description = "인증번호가 틀립니다.", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))),
            @ApiResponse(responseCode = "404\nMAIL_NOT_FOUND", description = "해당 메일주소 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "408\nEXPIRED_TIME", description = "인증번호 시간초과", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))),
    })
    @Operation(summary = "인증번호 인증" , description = "메일로 보낸 인증번호 인증")
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
