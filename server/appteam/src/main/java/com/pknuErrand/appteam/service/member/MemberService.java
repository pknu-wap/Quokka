package com.pknuErrand.appteam.service.member;

import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.dto.member.MemberFormDto;
import com.pknuErrand.appteam.repository.member.MemberRepository;
import jakarta.transaction.Transactional;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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

    public void SignUpProcess(MemberFormDto memberFormDto) {

        String mail = memberFormDto.getMail();
        String department = memberFormDto.getDepartment();
        String name = memberFormDto.getName();
        String id = memberFormDto.getId();
        String pw = memberFormDto.getPw();
        String nickname = memberFormDto.getNickname();

        memberRepository.save(new Member(mail, department, name, id, bCryptPasswordEncoder.encode(pw), nickname, 0, "ROLE_ADMIN"));
    }

    public Member findMemberById(String id) {

        Member member = memberRepository.findById(id);
        return member;
    }

    public Member getLoginMember() {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserDetails userDetails = (UserDetails)principal;
        String username = userDetails.getUsername();
        if(username == null)
            throw new IllegalArgumentException("로그인 되어있는 사용자 정보 없음");
        return findMemberById(username);
    }

    public boolean checkId(String Id) {

        return memberRepository.existsById(Id);
    }

    public boolean checkNickname(String nickname) {

        return memberRepository.existsByNickname(nickname);
    }
}