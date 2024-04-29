package com.pknuErrand.appteam.controller.member;

import com.pknuErrand.appteam.dto.member.MemberFormDto;
import com.pknuErrand.appteam.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

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
    public void SignUpProcess(@Valid @RequestBody MemberFormDto memberFormDto) {
        memberService.SignUpProcess(memberFormDto);
    }

    // 학번 중복확인
    @GetMapping("/join/{id}/idExists")
    public ResponseEntity<Boolean> CheckId(@PathVariable(value = "id") String id) {

        return ResponseEntity.ok(memberService.checkId(id));
    }

    // 닉네임 중복확인
    @GetMapping("/join/{nickname}/nicknameExists")
    public ResponseEntity<Boolean> CheckNickname(@PathVariable(value = "nickname") String nickname) {

        return ResponseEntity.ok(memberService.checkNickname(nickname));
    }
}
