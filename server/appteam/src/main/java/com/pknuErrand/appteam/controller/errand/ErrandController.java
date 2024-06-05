package com.pknuErrand.appteam.controller.errand;


import com.pknuErrand.appteam.dto.errand.*;
import com.pknuErrand.appteam.exception.ExceptionResponseDto;
import com.pknuErrand.appteam.service.errand.ErrandService;
import com.pknuErrand.appteam.service.member.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
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
import java.util.Map;

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
            @ApiResponse(responseCode = "200", description = "불러오기 성공", content = @Content(schema = @Schema(implementation = ErrandListResponseDto.class))),
            @ApiResponse(responseCode = "400\nINVALID_VALUE", description = "limit 값이 잘못되었음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "거리순으로 페이지네이션 불러오기")
    @GetMapping("/distance")
    public ResponseEntity<List<ErrandListResponseDto>> getPaginationErrandByDistance(ErrandDistancePaginationRequestVo pageInfo) {
        return ResponseEntity.ok()
                .body(errandService.findPaginationErrandByDistance(pageInfo));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "수락 성공", content = @Content(examples = {
                    @ExampleObject(
                            value = "{ \"name\": \"김수현\", \"nickname\": \"한상차림위샹체쯔\" }")
            })) ,
            @ApiResponse(responseCode = "404\nERRAND_NOT_FOUND", description = "심부름 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "401\nUNAUTHORIZED_ACCESS", description = "본인 게시물 수락할 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
            @ApiResponse(responseCode = "406\nRESTRICT_CONTENT_ACCESS", description = "진행중/완료 상태인 심부름 수락 불가능", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "요청서 수락하기", description = "요청서 수락요청을 통해 errand status 변경하기")
    @GetMapping("/{id}/accept")
    public ResponseEntity<Map<String, String>> acceptErrand(@PathVariable Long id) {
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


    @GetMapping("/all")
    public ResponseEntity<List<ErrandListResponseDto>> getAllErrand() {
        List<ErrandListResponseDto> errandListResponseDto = errandService.findAllErrand();
        return ResponseEntity.ok()
                .body(errandListResponseDto);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "조회 성공", content = @Content(examples = {
                    @ExampleObject(
                            value = "{ \"name\": \"김수현\", \"nickname\": \"한상차림위샹체쯔\" }")
            })),
            @ApiResponse(responseCode = "404\nERRAND_NOT_FOUND", description = "심부름 찾을 수 없음", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))),
            @ApiResponse(responseCode = "406\nRESTRICT_CONTENT_ACCESS", description = "모집중인 심부름의 심부름꾼 조회 불가", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))),
    })
    @GetMapping("/errander/{errandNo}")
    public ResponseEntity<Map<String, ?>> getErranderInfo(@PathVariable Long errandNo) {
        return ResponseEntity.ok()
                .body(errandService.getErranderInfo(errandNo));
    }
}
