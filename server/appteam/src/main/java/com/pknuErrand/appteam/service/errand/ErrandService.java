package com.pknuErrand.appteam.service.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandBuilder;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandRequestDto;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandResponseDto;
import com.pknuErrand.appteam.domain.errand.saveDto.ErrandSaveRequestDto;
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
         *    Member orderMember = memberService.findMemberById(errandSaveRequestDto.getOrderNo());
         *    member service 추가되면 수정 필요
         */
        Errand saveErrand = new ErrandBuilder()
//                .orderNo(errandSaveRequestDto.getOrderNo())
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
    public List<ErrandResponseDto> findAllErrand() {
        List<Errand> errandList = errandRepository.findAll();
        List<ErrandResponseDto> errandResponseDtoList = new ArrayList<>();
        for(Errand errand : errandList)
            errandResponseDtoList.add(new ErrandResponseDto(errand));
        return errandResponseDtoList;
    }

    @Transactional
    public ErrandResponseDto findErrandById(long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("사용자 없음"));
        return new ErrandResponseDto(errand);
    }
}
