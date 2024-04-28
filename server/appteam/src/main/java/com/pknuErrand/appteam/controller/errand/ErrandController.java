package com.pknuErrand.appteam.controller.errand;


import com.pknuErrand.appteam.domain.errand.getDto.ErrandListResponseDto;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandResponseDto;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandPaginationRequestVo;
import com.pknuErrand.appteam.domain.errand.saveDto.ErrandSaveRequestDto;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
import com.pknuErrand.appteam.service.errand.ErrandService;
import com.pknuErrand.appteam.service.member.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Tag(name = "Errand", description = "Errand 관련 API")
@Controller
@RequestMapping("/errand")
public class ErrandController {

    private final ErrandService errandService;
    private final MemberService memberService;

    @Autowired
    ErrandController(ErrandService errandService, MemberService memberService) {
        this.errandService = errandService;
        this.memberService = memberService;
    }


    @Operation(summary = "요청서 등록" , description = "심부름 요청서 등록")
    @PostMapping
    public ResponseEntity<?> createErrand(@RequestBody ErrandSaveRequestDto errandSaveRequestDto) {
        return ResponseEntity.ok()
                .body(errandService.createErrand(errandSaveRequestDto));
    }


    @Operation(summary = "요청서 전부 불러오기" , description = "사용 X")
    @GetMapping("/all")
    public ResponseEntity<List<ErrandListResponseDto>> getAllErrand() {
        List<ErrandListResponseDto> errandListResponseDto = errandService.findAllErrand();
        return ResponseEntity.ok()
                .body(errandListResponseDto);
    }

    @Operation(summary = "요청서 하나 불러오기" , description = "사용 X")
    @GetMapping("/{id}")  
    public ResponseEntity<ErrandDetailResponseDto> getOneErrand(@PathVariable Long id) {
        return ResponseEntity.ok()
                .body(errandService.findErrandById(id));
    }

    @Operation(summary = "최신순으로 페이지네이션 불러오기")
    @GetMapping("/latest")
    public ResponseEntity<List<ErrandListResponseDto>> getPaginationErrandByLatest(ErrandPaginationRequestVo pageInfo) {
        return ResponseEntity.ok()
                .body(errandService.findPaginationErrandByLatest(pageInfo));
    }

    @Operation(summary = "금액순으로 페이지네이션 불러오기")
    @GetMapping("/reward")
    public ResponseEntity<List<ErrandListResponseDto>> getPaginationErrandByReward(ErrandPaginationRequestVo pageInfo) {
        return ResponseEntity.ok()
                .body(errandService.findPaginationErrandByReward(pageInfo));
    }

    @Operation(summary = "요청서 수락하기", description = "요청서 수락요청을 통해 errand status 변경하기")
    @GetMapping("/{id}/accept")
    public ResponseEntity<ErrandDetailResponseDto> acceptErrand(@PathVariable Long id) {
        return ResponseEntity.ok()
                .body(errandService.acceptErrand(id));
    }

    @Operation(summary = "요청서 수정하기", description = "요청서 수정을 통해 errand field 변경하기")
    @PutMapping("/{id}")
    public ResponseEntity<ErrandDetailResponseDto> updateErrand(@PathVariable Long id, @RequestBody ErrandSaveRequestDto errandSaveRequestDto) {
        return ResponseEntity.ok()
                .body(errandService.updateErrand(id, errandSaveRequestDto));
    }

    @Operation(summary = "요청서 삭제하기", description = "요청서 삭제")
    @DeleteMapping("/{id}")
    public void deleteErrand(@PathVariable Long id) {
        errandService.deleteErrand(id);
    }

    @GetMapping("/loginTest")
    public void 로그인테스트() {
        Member member = memberService.getLoginMember();
        log.info("member id = {}", member.getId());
        log.info("member name = {}", member.getName());
        if(member == null)
            log.warn("member is null");
    }

}
