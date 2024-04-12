package com.pknuErrand.appteam.domain.member;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class MemberUserDetails implements UserDetails {

    private final MemberUserDetailsDto memberUserDetailsDto;

    public MemberUserDetails(MemberUserDetailsDto memberUserDetailsDto) {

        this.memberUserDetailsDto = memberUserDetailsDto;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {

        Collection<GrantedAuthority> collection = new ArrayList<>();

        // 주석 해도 되긴 되는데 검증 필요
        collection.add(new GrantedAuthority() {

            @Override
            public String getAuthority() {

                return memberUserDetailsDto.getRole();
            }
        });

        return List.of();
    }

    @Override
    public String getPassword() {

        return memberUserDetailsDto.getPw();
    }

    @Override
    public String getUsername() {

        return memberUserDetailsDto.getMail(); // get할거 바꿀시 수정
    }

    @Override
    public boolean isAccountNonExpired() {

        return true;
    }

    @Override
    public boolean isAccountNonLocked() {

        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {

        return true;
    }

    @Override
    public boolean isEnabled() {
        
        return true;
    }
}
