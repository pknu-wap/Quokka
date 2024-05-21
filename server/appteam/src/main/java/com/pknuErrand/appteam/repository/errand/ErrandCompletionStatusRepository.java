package com.pknuErrand.appteam.repository.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.errand.ErrandCompletionStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ErrandCompletionStatusRepository extends JpaRepository<ErrandCompletionStatus, Long> {
}
