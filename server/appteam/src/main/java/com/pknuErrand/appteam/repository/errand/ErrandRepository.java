package com.pknuErrand.appteam.repository.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ErrandRepository extends JpaRepository<Errand, Long> {
}
