package com.pknuErrand.appteam.service.statusMessage;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageRequestDto;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageResponseDto;
import com.pknuErrand.appteam.repository.StatusMessageRepository;
import com.pknuErrand.appteam.service.errand.ErrandService;
import com.pknuErrand.appteam.service.member.MemberService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StatusMessageService {
    private final StatusMessageRepository statusMessageRepository;
    private final MemberService memberService;
    private final ErrandService errandService;
    public StatusMessageService(StatusMessageRepository statusMessageRepository,
                                MemberService memberService,
                                ErrandService errandService) {
        this.statusMessageRepository = statusMessageRepository;
        this.memberService = memberService;
        this.errandService = errandService;
    }
    public StatusMessage saveStatusMessage(StatusMessageRequestDto statusMessageRequestDto) {
        Member errander = memberService.findMemberByMemberNo(statusMessageRequestDto.getErranderNo());
        Errand errand = errandService.findErrandById(statusMessageRequestDto.getErrandNo());
        StatusMessage message = StatusMessage.builder()
                .erranderNo(errander)
                .errandNo(errand)
                .contents(statusMessageRequestDto.getContents())
                .build();
        statusMessageRepository.save(message);
        return message;
    }
}
