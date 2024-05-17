package com.pknuErrand.appteam.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Tag(name = "Utility", description = "etc API")
@Controller
public class UtilityController {

    @GetMapping("/token/isValid")
    public ResponseEntity<String> isValidToken() {
        return ResponseEntity.ok()
                .body("ok");
    }
}
