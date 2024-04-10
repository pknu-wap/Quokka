package com.pknuErrand.appteam.service.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandBuilder;
import com.pknuErrand.appteam.domain.errand.Status;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandListResponseDto;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandResponseDto;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.domain.errand.saveDto.ErrandSaveRequestDto;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.member.MemberErrandDto;
import com.pknuErrand.appteam.repository.errand.ErrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ErrandService {

    private final ErrandRepository errandRepository;

    @Autowired
    ErrandService(ErrandRepository errandRepository) {
        this.errandRepository = errandRepository;
    }

    @Transactional
    public ErrandResponseDto createErrand(ErrandSaveRequestDto errandSaveRequestDto) {
        /**
         *    security context holder에서 인가된 사용자의 id를 받아오고 findById를 통해 member 객체 불러올 예정
         */
        Member orderMember = null; /** 인가된 사용자 정보 불러오기 **/
        
        Errand saveErrand = new ErrandBuilder()
                .orderNo(orderMember)
                .createdDate(errandSaveRequestDto.getCreatedDate())
                .title(errandSaveRequestDto.getTitle())
                .destination(errandSaveRequestDto.getDestination())
                .longitude(errandSaveRequestDto.getLongitude())
                .longitude(errandSaveRequestDto.getLongitude())
                .due(errandSaveRequestDto.getDue())
                .detail(errandSaveRequestDto.getDetail())
                .reward(errandSaveRequestDto.getReward())
                .isCash(errandSaveRequestDto.isCash())
                .status(errandSaveRequestDto.getStatus())
                .erranderNo(null)
                .build();
        errandRepository.save(saveErrand);
        return new ErrandResponseDto(saveErrand);
    }

    @Transactional
    public List<ErrandListResponseDto> findAllErrand() {
        List<Errand> errandList = errandRepository.findAll();
        List<ErrandListResponseDto> errandListResponseDtoList = new ArrayList<>();
        for(Errand errand : errandList) {
            MemberErrandDto memberErrandDto = buildMemberErrandDto(errand.getErranderNo());
            ErrandListResponseDto errandListResponseDto = new ErrandListResponseDto(
                    memberErrandDto, errand.getCreatedDate(), errand.getTitle(),
                    errand.getDestination(), errand.getReward(), errand.getStatus()
            );
            errandListResponseDtoList.add(errandListResponseDto);
        }
        return errandListResponseDtoList;
    }

    @Transactional
    public ErrandDetailResponseDto findErrandById(long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 심부름 없음"));
        MemberErrandDto memberErrandDto = buildMemberErrandDto(errand.getOrderNo());
        ErrandDetailResponseDto errandDetailResponseDto = new ErrandDetailResponseDto(
                memberErrandDto, errand.getCreatedDate(), errand.getTitle(), errand.getDestination(),
                errand.getLatitude(), errand.getLongitude(), errand.getDue(), errand.getDetail(),
                errand.getReward(), errand.isCash(), errand.getStatus()
        );
        return errandDetailResponseDto;
    }

    @Transactional
    public ErrandDetailResponseDto acceptErrand(Long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 심부름 없음"));
        Member errander = null;  /** 인가된 사용자 정보 불러오기 **/

        /** 실제 entity에 업데이트 하는 부분의 트랜잭션을 분리하여 변경 내용이 flush 되어 바로 변경된 errand정보를 response 할 수 있도록 한다. **/
        changeErrandStatusAndSetErrander(errand, Status.IN_PROGRESS, errander);
        return findErrandById(id);
    }

    @Transactional
    public void changeErrandStatusAndSetErrander(Errand errand, Status newStatus, Member errander) {
        errand.changeErrandStatusAndSetErrander(newStatus, errander);
    }
    @Transactional
    /**
     *    member domain 추가되면 확인 필요
     */
    public MemberErrandDto buildMemberErrandDto(Member member) {
        long memberNo = member.getMemberNo();
        String nickname = member.getNickname();
        double score = member.getScore();
        return new MemberErrandDto(memberNo, nickname, score);
    }


}
