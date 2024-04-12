package com.pknuErrand.appteam.service.member;

import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.member.MemberFormDto;
import com.pknuErrand.appteam.repository.member.MemberRepository;
import jakarta.transaction.Transactional;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


@Service
@Transactional
public class MemberService{

    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public MemberService(MemberRepository memberRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {

        this.memberRepository = memberRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    private void validateDuplicateMember(Member member) {
        memberRepository.findById(member.getId())
                .ifPresent(m -> {
                    throw new IllegalStateException("이미 존재하는 회원입니다.");
                });
    }

    public void SignUpProcess(MemberFormDto memberFormDto) {
        String mail = memberFormDto.getMail();
        String department = memberFormDto.getDepartment();
        String name = memberFormDto.getName();
        long id = memberFormDto.getId();
        String pw = memberFormDto.getPw();
        String nickname = memberFormDto.getNickname();
        double score = memberFormDto.getScore();
        String role = memberFormDto.getRole();

//        Boolean isExit = memberRepository.existByUsername(id); // mail 중복확인
//
//        if (isExit) {
//
//            return;
//        }

        memberRepository.save(new Member(mail, department, name, id, bCryptPasswordEncoder.encode(pw), nickname, 0, "user"));
    }
}