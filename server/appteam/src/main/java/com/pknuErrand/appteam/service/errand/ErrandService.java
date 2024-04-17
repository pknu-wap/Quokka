package com.pknuErrand.appteam.service.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandBuilder;
import com.pknuErrand.appteam.domain.errand.Sort;
import com.pknuErrand.appteam.domain.errand.Status;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandListResponseDto;
import com.pknuErrand.appteam.domain.errand.defaultDto.ErrandResponseDto;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandDetailResponseDto;
import com.pknuErrand.appteam.domain.errand.getDto.ErrandPaginationRequestVo;
import com.pknuErrand.appteam.domain.errand.saveDto.ErrandSaveRequestDto;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.member.MemberErrandDto;
import com.pknuErrand.appteam.repository.errand.ErrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static com.pknuErrand.appteam.domain.errand.Status.RECRUITING;

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
                .status(RECRUITING)
                .erranderNo(null)
                .build();
        errandRepository.save(saveErrand);
        return new ErrandResponseDto(saveErrand);
    }
    @Transactional(readOnly = true)
    public List<ErrandListResponseDto> findPaginationErrand(ErrandPaginationRequestVo pageInfo) {
        if(pageInfo.getLimit() <= 0)
            throw new IllegalArgumentException("limit은 1보다 같거나 커야합니다.");
        List<Errand> errandList = null;
        if(pageInfo.getSort() == Sort.LATEST) {
            if(pageInfo.getStatus() == null)
                errandList = errandRepository.findErrandByLatest(pageInfo.getPk(),(String)pageInfo.getCursor(), pageInfo.getLimit());
            else
                errandList = errandRepository.findErrandByStatusAndLatest(pageInfo.getPk(), (String) pageInfo.getCursor(), pageInfo.getLimit(), pageInfo.getStatus().toString());
        }
        else if(pageInfo.getSort() == Sort.REWARD) {
            if(pageInfo.getStatus() == null)
               errandList = errandRepository.findErrandByReward(pageInfo.getPk(), Integer.parseInt(pageInfo.getCursor()), pageInfo.getLimit());
            else
                errandList = errandRepository.findErrandByStatusAndReward(pageInfo.getPk(),Integer.parseInt(pageInfo.getCursor()), pageInfo.getLimit(), pageInfo.getStatus().toString());
        }
        else if(pageInfo.getSort() == Sort.DISTANCE) {
            /** 추가 거리 계산 로직 필요함 **/
        }

        /**
         * dto안에 list build 메소드 추가 예정
         */
        List<ErrandListResponseDto> errandListResponseDtoList = new ArrayList<>();

        /** for test
        for(Errand errand : errandList) {
            System.out.println(errand.getErrandNo() + " / " + errand.getTitle());
        }
        System.out.println("--------------------------------------");
         **/

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
    public ErrandDetailResponseDto findErrandById(long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 심부름 없음"));
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
                .isMyErrand(memberErrandDto.getErrandNo() == 5) /**  인가된 사용자 정보와 비교  **/
                .build();

        return errandDetailResponseDto;
    }

    @Transactional
    public ErrandDetailResponseDto acceptErrand(Long id) {
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 심부름 없음"));
        Member errander = null;  /** 인가된 사용자 정보 불러오기 **/

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
        String nickname ="tempNick"; // member.getNickname();
        double score = 0.2; // member.getScore();
        return new MemberErrandDto(memberNo, nickname, score);
    }

    @Transactional
    public ErrandDetailResponseDto updateErrand(Long id, ErrandSaveRequestDto errandSaveRequestDto) {
        /**
         *    security context holder에서 인가된 사용자의 id를 받아오고 findById를 통해 member 객체 불러올 예정
         */
        Member orderMember = null; /** 인가된 사용자 정보 불러오기 **/
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 심부름 없음"));
        if(!errand.getOrderNo().equals(orderMember)) {
            throw new IllegalArgumentException("게시물 수정 권한 없음"); /** 커스텀 Exception 생성 필요 **/
        }
        if(!errand.getStatus().equals(RECRUITING)) {
            throw new IllegalArgumentException("진행중이거나 완료된 심부름은 수정이 불가능합니다."); /** 커스텀 Exception 생성 필요 **/
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
        Member orderMember = null; /** 인가된 사용자 정보 불러오기 **/
        Errand errand = errandRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 심부름 없음"));
        if(!errand.getOrderNo().equals(orderMember)) {
            throw new IllegalArgumentException("게시물 수정 권한 없음"); /** 커스텀 Exception 생성 필요 **/
        }
        if(!errand.getStatus().equals(RECRUITING)) {
            throw new IllegalArgumentException("진행중이거나 완료된 심부름은 수정이 불가능합니다."); /** 커스텀 Exception 생성 필요 **/
        }
        errandRepository.delete(errand);
    }
}
