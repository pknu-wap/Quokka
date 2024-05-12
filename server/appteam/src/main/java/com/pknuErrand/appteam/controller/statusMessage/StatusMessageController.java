package com.pknuErrand.appteam.controller.statusMessage;


import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;

@Controller
public class StatusMessageController {

    @MessageMapping("/{errandNo}") // /app/{errandId}
    public void message(@DestinationVariable Long errandNo, StatusMessage statusMessage)
}
