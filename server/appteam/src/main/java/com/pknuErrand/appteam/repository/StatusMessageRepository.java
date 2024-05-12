package com.pknuErrand.appteam.repository;


import com.pknuErrand.appteam.domain.statusMessage.StatusMessage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusMessageRepository extends JpaRepository<StatusMessage, Long> {
}
