package com.pknuErrand.appteam.service.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandBuilder;
import com.pknuErrand.appteam.Enum.Status;
import com.pknuErrand.appteam.dto.errand.getDto.ErrandListResponseDto;
import com.pknuErrand.appteam.dto.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.dto.errand.getDto.ErrandPaginationRequestVo;
import com.pknuErrand.appteam.dto.errand.saveDto.ErrandSaveRequestDto;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.dto.member.MemberErrandDto;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
import com.pknuErrand.appteam.repository.errand.ErrandRepository;
import com.pknuErrand.appteam.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static com.pknuErrand.appteam.Enum.Status.RECRUITING;

@Service
public class ErrandService {

    private final ErrandRepository errandRepository;
    private final MemberService memberService;

    @Autowired
    ErrandService(ErrandRepository errandRepository, MemberService memberService) {
        this.errandRepository = errandRepository;
        this.memberService = memberService;
    }

    @Transactional
    public ErrandDetailResponseDto createErrand(ErrandSaveRequestDto errandSaveRequestDto) {

        Member orderMember = memberService.getLoginMember();

        Errand saveErrand = new ErrandBuilder()
                .orderNo(orderMember)
                .createdDate(errandSaveRequestDto.getCreatedDate())
                .title(errandSaveRequestDto.getTitle())
                .destination(errandSaveRequestDto.getDestination())
                .longitude(errandSaveRequestDto.getLongitude())
                .latitude(errandSaveRequestDto.getLatitude())
                .due(errandSaveRequestDto.getDue())
                .detail(errandSaveRequestDto.getDetail())
                .reward(errandSaveRequestDto.getReward())
                .isCash(errandSaveRequestDto.isCash())
                .status(RECRUITING)
                .erranderNo(null)
                .build();
        errandRepository.save(saveErrand);
        return findErrandById(saveErrand.getErrandNo());
    }

    @Transactional(readOnly = true)
    public void checkLimitAndThrowException(int limit) {
        if (limit <= 0)
            throw new CustomException(ErrorCode.INVALID_VALUE, "limit은 1보다 같거나 커야합니다.");
    }

    @Transactional(readOnly = true)
    public List<ErrandListResponseDto> findPaginationErrandByLatest(ErrandPaginationRequestVo pageInfo) {

        checkLimitAndThrowException(pageInfo.getLimit());
        List<Errand> errandList = null;

        if (!pageInfo.getCursor().contains("-"))
            throw new CustomException(ErrorCode.INVALID_FORMAT, "Cursor에 날짜/시간 형식을 넣어주세요.");
        else if (pageInfo.getStatus() == null)
            errandList = errandRepository.findErrandByLatest(pageInfo.getPk(), (String) pageInfo.getCursor(), pageInfo.getLimit());
        else
            errandList = errandRepository.findErrandByStatusAndLatest(pageInfo.getPk(), (String) pageInfo.getCursor(), pageInfo.getLimit(), pageInfo.getStatus().toString());

        return getFilteredErrandList(errandList);
    }

    @Transactional(readOnly = true)
    public List<ErrandListResponseDto> findPaginationErrandByReward(ErrandPaginationRequestVo pageInfo) {

        checkLimitAndThrowException(pageInfo.getLimit());
        List<Errand> errandList = null;

        try {
            if (Integer.parseInt(pageInfo.getCursor()) < 0)
                throw new CustomException(ErrorCode.INVALID_VALUE, "Cursor에 0원 이상의 값을 넣어주세요.");
        } catch (NumberFormatException e) {
            throw new CustomException(ErrorCode.INVALID_FORMAT, "REWARD (금액순) 일때는 Cursor에 0이상의 정수(금액)를 넣어주세요.");
        }
        if (pageInfo.getStatus() == null)
            errandList = errandRepository.findErrandByReward(pageInfo.getPk(), Integer.parseInt(pageInfo.getCursor()), pageInfo.getLimit());
        else
            errandList = errandRepository.findErrandByStatusAndReward(pageInfo.getPk(), Integer.parseInt(pageInfo.getCursor()), pageInfo.getLimit(), pageInfo.getStatus().toString());

        return getFilteredErrandList(errandList);
    }

    @Transactional(readOnly = true)
    public List<ErrandListResponseDto> getFilteredErrandList(List<Errand> errandList) {
        List<ErrandListResponseDto> errandListResponseDtoList = new ArrayList<>();

        for(Errand errand : errandList) {
            MemberErrandDto memberErrandDto = buildMemberErrandDto(errand.getErranderNo());

            ErrandListResponseDto errandListResponseDto = ErrandListResponseDto.builder()
                    .order(memberErrandDto)
                    .createdDate(errand.getCreatedDate())
                    .title(errand.getTitle())
                    .destination(errand.getDestination())
                    .reward(errand.getReward())
                    .status(errand.getStatus())
                    .build();

            errandListResponseDtoList.add(errandListResponseDto);
        }
        return errandListResponseDtoList;
    }

    @Transactional(readOnly = true)
    public List<ErrandListResponseDto> findAllErrand() {
        List<Errand> errandList = errandRepository.findAll();
        return getFilteredErrandList(errandList);
    }

    @Transactional(readOnly = true)
    public ErrandDetailResponseDto findErrandById(long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.ERRAND_NOT_FOUND));
        MemberErrandDto memberErrandDto = buildMemberErrandDto(errand.getOrderNo());

        ErrandDetailResponseDto errandDetailResponseDto = ErrandDetailResponseDto.builder()
                .order(memberErrandDto)
                .createdDate(errand.getCreatedDate())
                .title(errand.getTitle())
                .destination(errand.getDestination())
                .latitude(errand.getLatitude())
                .longitude(errand.getLongitude())
                .due(errand.getDue())
                .detail(errand.getDetail())
                .reward(errand.getReward())
                .isCash(errand.getIsCash())
                .status(errand.getStatus())
                .isMyErrand(memberErrandDto.getErrandNo() == memberService.getLoginMember().getMemberNo()) /**  인가된 사용자 정보와 비교  **/
                .build();

        return errandDetailResponseDto;
    }

    @Transactional
    public ErrandDetailResponseDto acceptErrand(Long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.ERRAND_NOT_FOUND));
        Member errander = memberService.getLoginMember();
        /** 본인 게시물이라면 예외 발생 **/
        if(errand.getOrderNo().getMemberNo() == errander.getMemberNo())
            throw new CustomException(ErrorCode.UNAUTHORIZED_ACCESS, "본인 게시물을 수락할 수 없습니다.");
        if(!errand.getStatus().equals(RECRUITING)) {
            throw new CustomException(ErrorCode.RESTRICT_CONTENT_ACCESS, "진행중이거나 완료된 심부름은 수락이 불가능합니다.");
        }
        changeErrandStatusAndSetErrander(errand, Status.IN_PROGRESS, errander);
        return findErrandById(id);
    }

    @Transactional
    public void changeErrandStatusAndSetErrander(Errand errand, Status newStatus, Member errander) {
        errand.changeErrandStatusAndSetErrander(newStatus, errander);
    }

    @Transactional
    public MemberErrandDto buildMemberErrandDto(Member member) {
        long memberNo = member.getMemberNo();
        String nickname = member.getNickname();
        double score = member.getScore();
        return new MemberErrandDto(memberNo, nickname, score);
    }

    @Transactional
    public ErrandDetailResponseDto updateErrand(Long id, ErrandSaveRequestDto errandSaveRequestDto) {

        Member orderMember = memberService.getLoginMember(); /** 인가된 사용자 정보 불러오기 **/
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.ERRAND_NOT_FOUND,"해당 심부름 없음"));
        if(!errand.getOrderNo().equals(orderMember)) {
            throw new CustomException(ErrorCode.UNAUTHORIZED_ACCESS, "본인 게시물만 수정할 수 있습니다.");
        }
        if(!errand.getStatus().equals(RECRUITING)) {
            throw new CustomException(ErrorCode.RESTRICT_CONTENT_ACCESS, "진행중이거나 완료된 심부름은 수정이 불가능합니다.");
        }
        errand.updateErrand(errandSaveRequestDto.getCreatedDate(),
                errandSaveRequestDto.getTitle(),
                errandSaveRequestDto.getDestination(),
                errandSaveRequestDto.getLatitude(),
                errandSaveRequestDto.getLongitude(),
                errandSaveRequestDto.getDue(),
                errandSaveRequestDto.getDetail(),
                errandSaveRequestDto.getReward(),
                errandSaveRequestDto.isCash());

        return findErrandById(id);
    }

    @Transactional
    public void deleteErrand(Long id) {
        Member orderMember = memberService.getLoginMember(); /** 인가된 사용자 정보 불러오기 **/
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.ERRAND_NOT_FOUND));
        if(!errand.getOrderNo().equals(orderMember)) {
            throw new CustomException(ErrorCode.UNAUTHORIZED_ACCESS, "본인 게시물만 삭제할 수 있습니다.");
        }
        if(!errand.getStatus().equals(RECRUITING)) {
            throw new CustomException(ErrorCode.RESTRICT_CONTENT_ACCESS, "진행중이거나 완료된 심부름은 수정이 불가능합니다.");
        }
        errandRepository.delete(errand);
    }
}
