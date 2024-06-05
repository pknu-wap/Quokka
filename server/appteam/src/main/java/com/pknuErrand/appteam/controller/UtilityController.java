package com.pknuErrand.appteam.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Tag(name = "Utility", description = "etc API")
@Controller
public class UtilityController {

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "유효한 토큰") ,
            @ApiResponse(responseCode = "403", description = "유효하지 않은 토큰") ,
    })
    @Operation(summary = "유효한 토큰인지 검증")
    @GetMapping("/token/isValid")
    public ResponseEntity<String> isValidToken() {
        return ResponseEntity.ok()
                .body("ok");
    }
}
