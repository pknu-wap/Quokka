package com.pknuErrand.appteam.service.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandBuilder;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandListResponseDto;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandRequestDto;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandResponseDto;
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
        Member orderMember = null;
        
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
            errandListResponseDtoList.add(ErrandListResponseDto);
        }
        return errandListResponseDtoList;
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

    @Transactional
    public ErrandResponseDto findErrandById(long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("사용자 없음"));
        return new ErrandResponseDto(errand);
    }
}
