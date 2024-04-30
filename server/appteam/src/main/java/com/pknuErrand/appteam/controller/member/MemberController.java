package com.pknuErrand.appteam.controller.member;

import com.pknuErrand.appteam.dto.member.MemberFormDto;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
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
    public void SignUpProcess(@Valid @RequestBody MemberFormDto memberFormDto) {

        memberService.SignUpProcess(memberFormDto);
    }

    // 학번 중복확인
    @GetMapping("/join/{id}/idExists")
    public void CheckId(@PathVariable(value = "id") String id) {

        if(!memberService.checkId(id))
            throw new CustomException(ErrorCode.DUPLICATE_DATA, "중복된 학번입니다.");
    }

    // 닉네임 중복확인
    @GetMapping("/join/{nickname}/nicknameExists")
    public void CheckNickname(@PathVariable(value = "nickname") String nickname) {

        if(!memberService.checkNickname(nickname))
            throw new CustomException(ErrorCode.DUPLICATE_DATA, "중복된 닉네임입니다.");
    }
}
