package com.pknuErrand.appteam.service.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandRequestDto;
import com.pknuErrand.appteam.domain.errand.ErrandResponseDto;
import com.pknuErrand.appteam.repository.errand.ErrandRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ErrandService {

    private final ErrandRepository errandRepository;

    ErrandService(ErrandRepository errandRepository) {
        this.errandRepository = errandRepository;
    }

    @Transactional
    public ErrandResponseDto createErrand(ErrandRequestDto errandRequestDto) {
        Errand saveErrand = new Errand(errandRequestDto);
        errandRepository.save(saveErrand);
        return new ErrandResponseDto(saveErrand);
    }
}
