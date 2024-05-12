package com.pknuErrand.appteam.controller.statusMessage;


import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageRequestDto;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageResponseDto;
import com.pknuErrand.appteam.service.statusMessage.StatusMessageService;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class StatusMessageController {

    private final StatusMessageService statusMessageService;
    public StatusMessageController(StatusMessageService statusMessageService) {
        this.statusMessageService = statusMessageService;
    }

    @MessageMapping("/{errandNo}") // /app/{errandId}
    @SendTo("/queue/{errandNo}")
    public StatusMessageResponseDto message(@DestinationVariable Long errandNo, StatusMessageRequestDto statusMessageRequestDto) {
        StatusMessage message = statusMessageService.saveStatusMessage(statusMessageRequestDto);
        return new StatusMessageResponseDto(message);
    }
}
