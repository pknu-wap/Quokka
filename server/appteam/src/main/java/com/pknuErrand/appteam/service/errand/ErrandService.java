package com.pknuErrand.appteam.service.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandRequestDto;
import com.pknuErrand.appteam.domain.errand.ErrandResponseDto;
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
    public ErrandResponseDto createErrand(ErrandRequestDto errandRequestDto) {
        Errand saveErrand = new Errand(errandRequestDto);
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
}
