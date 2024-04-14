package com.pknuErrand.appteam.controller.errand;


import com.pknuErrand.appteam.domain.errand.getDto.ErrandListResponseDto;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandResponseDto;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.domain.errand.saveDto.ErrandSaveRequestDto;
import com.pknuErrand.appteam.service.errand.ErrandService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Errand", description = "Errand 관련 API")
@Controller
@RequestMapping("/errand")
public class ErrandController {

    private final ErrandService errandService;

    @Autowired
    ErrandController(ErrandService errandService) {
        this.errandService = errandService;
    }


    @Operation(summary = "요청서 등록" , description = "심부름 요청서 등록")
    @PostMapping
    public ResponseEntity<ErrandResponseDto> createErrand(@RequestBody ErrandSaveRequestDto errandSaveRequestDto) {
        return ResponseEntity.ok()
                .body(errandService.createErrand(errandSaveRequestDto));
    }

    @Operation(summary = "요청서 전부 불러오기" , description = "심부름 요청서 전부 불러오기")
    @GetMapping
    public ResponseEntity<List<ErrandListResponseDto>> getAllErrand() {
        List<ErrandListResponseDto> errandListResponseDto = errandService.findAllErrand();
        return ResponseEntity.ok()
                .body(errandListResponseDto);
    }

    @Operation(summary = "요청서 하나 불러오기" , description = "요청서의 PK (id) 를 통해 불러오기")
    @GetMapping("/{id}")  
    public ResponseEntity<ErrandDetailResponseDto> getOneErrand(@PathVariable Long id) {
        return ResponseEntity.ok()
                .body(errandService.findErrandById(id));
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
}
