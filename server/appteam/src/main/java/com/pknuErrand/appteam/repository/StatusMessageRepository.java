package com.pknuErrand.appteam.repository;


import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StatusMessageRepository extends JpaRepository<StatusMessage, Long> {
    List<StatusMessage> findByErrandNo(Errand errandNo);
}
