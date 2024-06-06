package com.pknuErrand.appteam.repository.errand;
import com.pknuErrand.appteam.domain.errand.Errand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ErrandRepository extends JpaRepository<Errand, Long> {

    @Query(value = "SELECT * " +
            "FROM errand " +
            "WHERE (created_date = :cursor AND errand_no > :pk) OR created_date < :cursor " +
            "ORDER BY created_date DESC, errand_no DESC LIMIT :limit", nativeQuery = true)
    List<Errand> findErrandByLatest(@Param("pk") Long pk, @Param("cursor") String cursor, @Param("limit") int limit);

    @Query(value = "SELECT * " +
            "FROM errand " +
            "WHERE (status = :status) AND ((created_date = :cursor AND errand_no > :pk) OR created_date < :cursor) " +
            "ORDER BY created_date DESC, errand_no DESC LIMIT :limit", nativeQuery = true)
    List<Errand> findErrandByStatusAndLatest(@Param("pk") Long pk, @Param("cursor") String cursor, @Param("limit") int limit,
                                             @Param("status") String status);

    @Query(value = "SELECT * " +
            "FROM errand " +
            "WHERE (reward = :cursor AND errand_no > :pk) OR reward < :cursor " +
            "ORDER BY reward DESC, errand_no DESC LIMIT :limit", nativeQuery = true)
    List<Errand> findErrandByReward(@Param("pk") Long pk, @Param("cursor") int cursor, @Param("limit") int limit);

    @Query(value = "SELECT * " +
            "FROM errand " +
            "WHERE (status = :status) AND ((reward = :cursor AND errand_no > :pk) OR reward < :cursor) " +
            "ORDER BY reward DESC, errand_no DESC LIMIT :limit", nativeQuery = true)
    List<Errand> findErrandByStatusAndReward(@Param("pk") Long pk, @Param("cursor") int cursor, @Param("limit") int limit,
                                              @Param("status") String status);

}
