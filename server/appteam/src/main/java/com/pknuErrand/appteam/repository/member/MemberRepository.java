package com.pknuErrand.appteam.repository.member;

import com.pknuErrand.appteam.domain.member.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {

    //    Boolean existByUsername(long id);
    Optional<Member> findByMail(String mail);

    Member findByName(String mail);

//    Member findById(String id);
}
