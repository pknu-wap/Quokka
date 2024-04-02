package com.pknuErrand.appteam.controller.errand;


import com.pknuErrand.appteam.domain.errand.ErrandRequestDto;
import com.pknuErrand.appteam.domain.errand.ErrandResponseDto;
import com.pknuErrand.appteam.repository.errand.ErrandRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/errand")
public class ErrandController {
    /**
    private final ErrandService errandService;
     + 생성자 주입
    **/

    @PostMapping /** Eraand 등록 **/
    public ResponseEntity<ErrandRequestDto> createErrand(@RequestBody ErrandRequestDto errandRequestDto) {
        /**
         * Errand를 entity(db)에 저장하는 로직
         */
        return ResponseEntity.ok()
                .body(errand);
    }
    @GetMapping
    public ResponseEntity<List<ErrandResponseDto>> getAllErrand() {
        /**
         * 모든 Errand를 불러오는 로직
         */
        return ResponseEntity.ok()
                .body(list~~)
    }
    @GetMapping("/{id}")   /** Errand 하나 조회 **/
    public ResponseEntity<ErrandResponseDto> getOneErrand(@PathVariable Long id) {
        /**
         * Errand pk id로부터 하나의 errand를 불러오는 로작
         */
        return ResponseEntity.ok()
                .body(errand)
    }
}
