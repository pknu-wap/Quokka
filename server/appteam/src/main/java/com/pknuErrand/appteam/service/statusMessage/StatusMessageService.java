package com.pknuErrand.appteam.service.statusMessage;

import com.pknuErrand.appteam.Enum.Status;
import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandCompletionStatus;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageRequestDto;
import com.pknuErrand.appteam.dto.statusMessage.StatusMessageResponseDto;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
import com.pknuErrand.appteam.repository.StatusMessageRepository;
import com.pknuErrand.appteam.repository.errand.ErrandCompletionStatusRepository;
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
    private final ErrandCompletionStatusRepository errandCompletionStatusRepository;
    private final MemberService memberService;
    private final ErrandService errandService;
    public StatusMessageService(StatusMessageRepository statusMessageRepository,
                                ErrandCompletionStatusRepository errandCompletionStatusRepository,
                                MemberService memberService,
                                ErrandService errandService) {
        this.statusMessageRepository = statusMessageRepository;
        this.memberService = memberService;
        this.errandService = errandService;
        this.errandCompletionStatusRepository = errandCompletionStatusRepository;
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

    public void erranderCompletionConfirm(Long errandNo) {
        Member errander = memberService.getLoginMember();
        Errand errand = errandService.findErrandById(errandNo);
        if(!errand.getErranderNo().equals(errander))
            throw new CustomException(ErrorCode.UNAUTHORIZED_ACCESS, "요청한 사용자가 Errander가 아닙니다.");
        errand.getErrandCompletionStatus().setErranderConfirmed(true);
    }

    public void orderCompletionConfirm(Long errandNo) {
        Member order = memberService.getLoginMember();
        Errand errand = errandService.findErrandById(errandNo);
        if(!errand.getOrderNo().equals(order))
            throw new CustomException(ErrorCode.UNAUTHORIZED_ACCESS, "요청한 사용자가 Order가 아닙니다.");
        ErrandCompletionStatus errandCompletionStatus = errand.getErrandCompletionStatus();
        if(!errandCompletionStatus.isErranderConfirmed())
            throw new CustomException(ErrorCode.RESTRICT_CONTENT_ACCESS, "아직 Errander가 완료처리하지 않았습니다.");
        errandCompletionStatus.setOrderConfirmed(true);
        errandService.changeErrandStatusAndSetErrander(errand, Status.DONE, errand.getErranderNo());
    }
}
