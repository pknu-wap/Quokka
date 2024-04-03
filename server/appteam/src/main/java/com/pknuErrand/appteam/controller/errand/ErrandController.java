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


    @Operation(summary = "심부름 요청서" , description = "심부름 요청서 등록")
    @PostMapping /** Eraand 등록 **/
    public ResponseEntity<ErrandResponseDto> createErrand(@RequestBody ErrandRequestDto errandRequestDto) {
        return ResponseEntity.ok()
                .body(errandService.createErrand(errandRequestDto));
    }

    @Operation(summary = "심부름 요청서" , description = "심부름 요청서 전부 불러오기")
    @GetMapping /** Errand 전부 불러오기 **/
    public ResponseEntity<List<ErrandResponseDto>> getAllErrand() {
        List<ErrandResponseDto> errandResponseDtoList = errandService.findAllErrand();
        return ResponseEntity.ok()
                .body(errandResponseDtoList);
    }



//    @GetMapping("/{id}")   /** Errand 하나 조회 **/
//    public ResponseEntity<ErrandResponseDto> getOneErrand(@PathVariable Long id) {
//        /**
//         * Errand pk id로부터 하나의 errand를 불러오는 로작
//         */
//        return ResponseEntity.ok();
//    }
}
