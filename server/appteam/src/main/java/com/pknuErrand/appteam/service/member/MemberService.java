package com.pknuErrand.appteam.service.member;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.dto.member.MemberFormDto;
import com.pknuErrand.appteam.exception.CustomException;
import com.pknuErrand.appteam.exception.ErrorCode;
import com.pknuErrand.appteam.repository.errand.ErrandRepository;
import com.pknuErrand.appteam.repository.member.MemberRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberService{

    private final MemberRepository memberRepository;
    private final ErrandRepository errandRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    public MemberService(MemberRepository memberRepository, BCryptPasswordEncoder bCryptPasswordEncoder, ErrandRepository errandRepository) {

        this.memberRepository = memberRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.errandRepository = errandRepository;
    }

    @Transactional
    public void SignUpProcess(MemberFormDto memberFormDto) {

        String mail = memberFormDto.getMail();
        String department = memberFormDto.getDepartment();
        String name = memberFormDto.getName();
        String id = memberFormDto.getId();
        String pw = memberFormDto.getPw();
        String nickname = memberFormDto.getNickname();

        memberRepository.save(new Member(mail, department, name, id, bCryptPasswordEncoder.encode(pw), nickname, 100, "ROLE_ADMIN"));
    }

    @Transactional
    public Member findMemberById(String id) {

        Member member = memberRepository.findById(id);
        return member;
    }

    @Transactional
    public Member findMemberByMemberNo(long id) {
        return memberRepository.findMemberByMemberNo(id);
    }

    @Transactional
    public Member getLoginMember() {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserDetails userDetails = (UserDetails)principal;
        String username = userDetails.getUsername();
        if(username == null)
            throw new IllegalArgumentException("로그인 되어있는 사용자 정보 없음");
        return findMemberById(username);
    }

    @Transactional
    public boolean checkId(String Id) {

        return memberRepository.existsById(Id);
    }

    @Transactional
    public boolean checkNickname(String nickname) {

        return memberRepository.existsByNickname(nickname);
    }

    @Transactional
    public void updateScore(long errandNo, double score) {

        Errand errand = errandRepository.findById(errandNo).orElseThrow(() -> new CustomException(ErrorCode.ERRAND_NOT_FOUND));

        Member updatedMember = null;

        // True면 Errander(심부름 꾼)이 반환됨
        if(isMyErrand(errand, getLoginMember().getMemberNo()))
            updatedMember = errand.getErranderNo();

        // False면 Order(심부름 시킨 사람)이 반환 됨
        else
            updatedMember = errand.getOrderNo();

        double finScore = updatedMember.getScore() + calScore(score);
        updatedMember.updateScore(finScore);
        memberRepository.save(updatedMember);
    }

    @Transactional
    public Boolean isMyErrand(Errand errand, Long memberNo)  { /** Parameter : Errand 객체, Member pk (long) **/
        // order == 심부름 시킨 사람, errander == 심부름 한 사람
        return errand.getOrderNo().getMemberNo() == memberNo;
    }

    @Transactional
    double calScore(double score) {
        double addScore = 0;
        switch ((int)score) {
            case 1:
                addScore = -5;
                break;
            case 3:
                addScore = 3;
                break;
            case 4:
                addScore = 8;
                break;
            case 5:
                addScore = 12;
                break;
        }
        return addScore;
    }

}