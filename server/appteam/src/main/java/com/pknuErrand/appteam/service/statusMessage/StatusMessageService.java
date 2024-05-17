package com.pknuErrand.appteam.service.statusMessage;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageRequestDto;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageResponseDto;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
import com.pknuErrand.appteam.repository.StatusMessageRepository;
import com.pknuErrand.appteam.service.errand.ErrandService;
import com.pknuErrand.appteam.service.member.MemberService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

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
    public StatusMessage saveStatusMessage(StatusMessageRequestDto statusMessageRequestDto, Long errandNo) {
        Member errander = memberService.findMemberByMemberNo(statusMessageRequestDto.getErranderNo());
        Errand errand = errandService.findErrandById(errandNo);
        StatusMessage message = StatusMessage.builder()
                .erranderNo(errander)
                .errandNo(errand)
                .contents(statusMessageRequestDto.getContents())
                .build();
        statusMessageRepository.save(message);
        return message;
    }

    public List<StatusMessageResponseDto> getStatusMessageList(Long errandNo) {
        Errand errand = errandService.findErrandById(errandNo);
        if(!memberService.getLoginMember().equals(errand.getErranderNo()) && !memberService.getLoginMember().equals(errand.getOrderNo()))
            throw new CustomException(ErrorCode.UNAUTHORIZED_ACCESS);
        List<StatusMessage> list = statusMessageRepository.findByErrandNo(errand);
        List<StatusMessageResponseDto> filteredStatusMessageList = new ArrayList<>();
        for(StatusMessage message : list) {
            StatusMessageResponseDto filteredStatusMessage = new StatusMessageResponseDto(message);
            filteredStatusMessageList.add(filteredStatusMessage);
        }
        return filteredStatusMessageList;
    }
}
