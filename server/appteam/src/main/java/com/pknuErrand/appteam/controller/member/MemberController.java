package com.pknuErrand.appteam.controller.member;

import com.pknuErrand.appteam.domain.member.MemberFormDto;
import com.pknuErrand.appteam.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
