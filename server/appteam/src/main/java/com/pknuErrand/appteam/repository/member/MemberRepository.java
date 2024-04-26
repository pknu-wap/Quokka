package com.pknuErrand.appteam.repository.member;

import com.pknuErrand.appteam.domain.member.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long> {

    Member findById(String id);
    boolean existsByMail(String mail);
    boolean existsByNickname(String nickname);
}
