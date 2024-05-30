package com.pknuErrand.appteam.controller.member;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.dto.member.MemberFormDto;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
import com.pknuErrand.appteam.exception.ExceptionResponseDto;
import com.pknuErrand.appteam.service.member.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Tag(name = "Member", description = "Member 관련 API")
@Controller
@ResponseBody
public class MemberController {

    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {

        this.memberService = memberService;
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "회원 가입 성공") ,
            @ApiResponse(responseCode = "415\nINVALID_FORMAT", description = "회원 가입 실패", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "회원 가입", description = "회원 가입 기능")
    @PostMapping("/join")
    public void SignUpProcess(@Valid @RequestBody MemberFormDto memberFormDto) {

        memberService.SignUpProcess(memberFormDto);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "중복된 학번이 없습니다.") ,
            @ApiResponse(responseCode = "400\nDUPLICATE_DATA", description = "중복된 학번입니다.", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "학번 중복 확인", description = "회원 가입 시 학번 중복 확인")
    @GetMapping("/join/{id}/idExists")
    public void CheckId(@PathVariable(value = "id") String id) {

        if(memberService.checkId(id))
            throw new CustomException(ErrorCode.DUPLICATE_DATA, "중복된 학번입니다.");
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "중복된 닉네임이 없습니다.") ,
            @ApiResponse(responseCode = "400\nDUPLICATE_DATA", description = "중복된 닉네임입니다.", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "닉네임 중복 확인", description = "회원 가입 시 닉네임 중복 확인")
    @GetMapping("/join/{nickname}/nicknameExists")
    public void CheckNickname(@PathVariable(value = "nickname") String nickname) {
        
        if(memberService.checkNickname(nickname))
            throw new CustomException(ErrorCode.DUPLICATE_DATA, "중복된 닉네임입니다.");
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "평가 완료") ,
            @ApiResponse(responseCode = "404\nUSER_NOT_FOUND", description = "유저 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "상대방 평가", description = "상대방 1 ~ 5점으로 평가")
    @PutMapping("/score")
    public void getMemberScore(@RequestParam("errandNo") long errandNo, @RequestParam("score") double score) {

        memberService.updateScore(errandNo, score);
    }

}
