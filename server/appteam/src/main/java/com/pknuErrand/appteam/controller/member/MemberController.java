package com.pknuErrand.appteam.controller.member;

import com.pknuErrand.appteam.domain.member.MemberFormDto;
import com.pknuErrand.appteam.service.member.MemberService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@ResponseBody
public class MemberController {

    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {

        this.memberService = memberService;
    }

    // 회원가입
    @PostMapping("/join")
    public String SignUpProcess(@RequestBody MemberFormDto memberFormDto) {

        memberService.SignUpProcess(memberFormDto);

        return "회원가입 완료";
    }

    // 이메일 중복확인
    @GetMapping("/{mail}/exists")
    public ResponseEntity<Boolean> CheckMail(@PathVariable(value = "mail") String mail) {

        System.out.println(mail + "\n\n");
        return ResponseEntity.ok(memberService.checkMail(mail));
    }

    // 닉네임 중복확인
    @GetMapping("/{nickname}/nicknameexists")
    public ResponseEntity<Boolean> CheckNickname(@PathVariable(value = "nickname") String nickname) {

        System.out.println(nickname + " \n\n");
        return ResponseEntity.ok(memberService.checkNickname(nickname));
    }
}
