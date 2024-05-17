package com.pknuErrand.appteam.controller.errand;


import com.pknuErrand.appteam.dto.errand.getDto.ErrandListResponseDto;
import com.pknuErrand.appteam.dto.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.dto.errand.getDto.ErrandPaginationRequestVo;
import com.pknuErrand.appteam.dto.errand.getDto.InProgressErrandListResponseDto;
import com.pknuErrand.appteam.dto.errand.saveDto.ErrandSaveRequestDto;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.exception.ExceptionResponseDto;
import com.pknuErrand.appteam.service.errand.ErrandService;
import com.pknuErrand.appteam.service.member.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
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


    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "저장 성공", content = @Content(schema = @Schema(implementation = ErrandDetailResponseDto.class))) ,
            @ApiResponse(responseCode = "415", description = "데이터가 잘못되었음 (공백 , null 등)", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "요청서 등록" , description = "심부름 요청서 등록")
    @PostMapping
    public ResponseEntity<?> createErrand(@Valid @RequestBody ErrandSaveRequestDto errandSaveRequestDto) {
        return ResponseEntity.ok()
                .body(errandService.createErrand(errandSaveRequestDto));
    }
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "불러오기 성공", content = @Content(schema = @Schema(implementation = ErrandDetailResponseDto.class))) ,
            @ApiResponse(responseCode = "404", description = "심부름 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "요청서 하나 불러오기" , description = "심부름 요청서 불러오기")
    @GetMapping("/{id}")
    public ResponseEntity<ErrandDetailResponseDto> getOneErrand(@PathVariable Long id) {
        return ResponseEntity.ok()
                .body(errandService.findErrandDetailById(id));
    }


    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "불러오기 성공", content = @Content(schema = @Schema(implementation = ErrandListResponseDto.class))) ,
            @ApiResponse(responseCode = "400\nINVALID_VALUE", description = "limit 값이 잘못되었음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "415\nINVALID_FORMAT", description = "Cursor format이 잘못되었음(날짜/시간)", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "최신순으로 페이지네이션 불러오기")
    @GetMapping("/latest")
    public ResponseEntity<List<ErrandListResponseDto>> getPaginationErrandByLatest(ErrandPaginationRequestVo pageInfo) {
        return ResponseEntity.ok()
                .body(errandService.findPaginationErrandByLatest(pageInfo));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "불러오기 성공", content = @Content(schema = @Schema(implementation = ErrandListResponseDto.class))) ,
            @ApiResponse(responseCode = "400\nINVALID_VALUE", description = "limit 값이 잘못되었거나 Cursor가 0보다 작음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "415\nINVALID_FORMAT", description = "Cursor format이 잘못되었음(금액)", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "금액순으로 페이지네이션 불러오기")
    @GetMapping("/reward")
    public ResponseEntity<List<ErrandListResponseDto>> getPaginationErrandByReward(ErrandPaginationRequestVo pageInfo) {
        return ResponseEntity.ok()
                .body(errandService.findPaginationErrandByReward(pageInfo));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "수락 성공", content = @Content(schema = @Schema(implementation = ErrandDetailResponseDto.class))) ,
            @ApiResponse(responseCode = "404\nERRAND_NOT_FOUND", description = "심부름 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "401\nUNAUTHORIZED_ACCESS", description = "본인 게시물 수락할 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "406\nRESTRICT_CONTENT_ACCESS", description = "진행중/완료 상태인 심부름 수락 불가능", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "요청서 수락하기", description = "요청서 수락요청을 통해 errand status 변경하기")
    @GetMapping("/{id}/accept")
    public ResponseEntity<ErrandDetailResponseDto> acceptErrand(@PathVariable Long id) {
        return ResponseEntity.ok()
                .body(errandService.acceptErrand(id));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "수정 성공", content = @Content(schema = @Schema(implementation = ErrandDetailResponseDto.class))) ,
            @ApiResponse(responseCode = "404\nERRAND_NOT_FOUND", description = "심부름 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "401\nUNAUTHORIZED_ACCESS", description = "본인 게시물이 아니면 수정 불가능", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "406\nRESTRICT_CONTENT_ACCESS", description = "진행중/완료 상태인 심부름 수정 불가능", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "요청서 수정하기", description = "요청서 수정을 통해 errand field 변경하기")
    @PutMapping("/{id}")
    public ResponseEntity<ErrandDetailResponseDto> updateErrand(@PathVariable Long id, @RequestBody ErrandSaveRequestDto errandSaveRequestDto) {
        return ResponseEntity.ok()
                .body(errandService.updateErrand(id, errandSaveRequestDto));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "삭제 성공", content = @Content(schema = @Schema(implementation = ErrandDetailResponseDto.class))) ,
            @ApiResponse(responseCode = "404\nERRAND_NOT_FOUND", description = "심부름 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "401\nUNAUTHORIZED_ACCESS", description = "본인 게시물이 아니면 삭제 불가능", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "406\nRESTRICT_CONTENT_ACCESS", description = "진행중/완료 상태인 심부름 삭제 불가능", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "요청서 삭제하기", description = "요청서 삭제")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteErrand(@PathVariable Long id) {
        errandService.deleteErrand(id);
        return ResponseEntity.ok().build();
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "진행중인 심부름 있음") ,
            @ApiResponse(responseCode = "404", description = "진행중인 심부름 없음") ,
    })
    @Operation(summary = "사용자의 진행중인 심부름 여부 확인")
    @GetMapping("/in-progress/exist")
    public ResponseEntity<Void> checkInProgressErrandExist() {
        errandService.checkInProgressErrandExist();
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "사용자의 진행중인 심부름 불러오기")
    @GetMapping("/in-progress")
    public ResponseEntity<List<InProgressErrandListResponseDto>> getInProgressErrand() {
        List<InProgressErrandListResponseDto> list = errandService.getInProgressErrand();
        return ResponseEntity.ok()
                .body(list);
    }


    @GetMapping("/all")
    public ResponseEntity<List<ErrandListResponseDto>> getAllErrand() {
        List<ErrandListResponseDto> errandListResponseDto = errandService.findAllErrand();
        return ResponseEntity.ok()
                .body(errandListResponseDto);
    }


}
