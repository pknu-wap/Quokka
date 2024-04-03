package com.pknuErrand.appteam.controller.errand;


import com.pknuErrand.appteam.domain.errand.ErrandRequestDto;
import com.pknuErrand.appteam.domain.errand.ErrandResponseDto;
import com.pknuErrand.appteam.repository.errand.ErrandRepository;
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
    public ResponseEntity<ErrandResponseDto> createErrand(@RequestBody ErrandRequestDto errandRequestDto) {
        return ResponseEntity.ok()
                .body(errandService.createErrand(errandRequestDto));
    }

    @Operation(summary = "요청서 전부 불러오기" , description = "심부름 요청서 전부 불러오기")
    @GetMapping
    public ResponseEntity<List<ErrandResponseDto>> getAllErrand() {
        List<ErrandResponseDto> errandResponseDtoList = errandService.findAllErrand();
        return ResponseEntity.ok()
                .body(errandResponseDtoList);
    }

    @Operation(summary = "요청서 하나 불러오기" , description = "요청서의 PK (id) 를 통해 불러오기")
    @GetMapping("/{id}")  
    public ResponseEntity<ErrandResponseDto> getOneErrand(@PathVariable Long id) {
        return ResponseEntity.ok()
                .body(errandService.findErrandById(id));
    } // 
}
