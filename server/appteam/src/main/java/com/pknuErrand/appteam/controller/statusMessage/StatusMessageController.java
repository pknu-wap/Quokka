package com.pknuErrand.appteam.controller.statusMessage;


import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import com.pknuErrand.appteam.dto.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageRequestDto;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageResponseDto;
import com.pknuErrand.appteam.exception.ExceptionResponseDto;
import com.pknuErrand.appteam.service.statusMessage.StatusMessageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Slf4j
@Tag(name = "Status Message", description = "현황 페이지 관련 API")
@Controller
public class StatusMessageController {

    private final StatusMessageService statusMessageService;
    public StatusMessageController(StatusMessageService statusMessageService) {
        this.statusMessageService = statusMessageService;
    }

    @MessageMapping("/{errandNo}") // /app/{errandId}
    @SendTo("/queue/{errandNo}")
    public StatusMessageResponseDto message(@DestinationVariable Long errandNo, StatusMessageRequestDto statusMessageRequestDto) {
        StatusMessage message = statusMessageService.saveStatusMessage(statusMessageRequestDto, errandNo);
        log.info(message.getContents());
        return new StatusMessageResponseDto(message);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "불러오기 성공", content = @Content(schema = @Schema(implementation = StatusMessageResponseDto.class))) ,
            @ApiResponse(responseCode = "401\nUNAUTHORIZED_ACCESS", description = "권한이 없는 사용자", content = @Content(schema = @Schema(implementation = ExceptionResponseDto.class))) ,
    })
    @Operation(summary = "현황페이지 메시지내역 불러오기" , description = "웹소켓 연결 전 불러와야함")
    @GetMapping("/statusMessage/{errandNo}")
    public ResponseEntity<List<StatusMessageResponseDto>> getStatusMessageList(@PathVariable Long errandNo) {
        return ResponseEntity.ok()
                .body(statusMessageService.getStatusMessageList(errandNo));
    }
}
