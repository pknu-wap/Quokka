package com.pknuErrand.appteam.service.member;

import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.member.MemberUserDetails;
import com.pknuErrand.appteam.repository.member.MemberRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class MemberUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    public MemberUserDetailsService(MemberRepository memberRepository) {

        this.memberRepository = memberRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String mail) throws UsernameNotFoundException {

        // DB에서 조회
        Member memberData = memberRepository.findByName(mail);  // findByUsername

        if (memberData != null) {
            
            // UserDetails에 담아서 return하면 AuthenticationManager가 검증 함
            return new MemberUserDetails(memberData);
        }

        return null;
    }
}
