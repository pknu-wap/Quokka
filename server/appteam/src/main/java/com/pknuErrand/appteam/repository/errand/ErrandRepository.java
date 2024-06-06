package com.pknuErrand.appteam.repository.errand;
import com.pknuErrand.appteam.Enum.Status;
import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.dto.errand.ErrandDistanceListDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;

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

    @Query(value = "SELECT * " +
            "FROM errand " +
            "WHERE ((errander_no_member_no =:memberNo) OR (order_no_member_no =:memberNo)) AND (status = 'IN_PROGRESS')", nativeQuery = true)
    List<Errand> findInProgressErrand(@Param("memberNo") Long memberNo);


    @Query("SELECT new com.pknuErrand.appteam.dto.errand.ErrandDistanceListDto(" +
            "e.orderNo, e.errandNo, e.createdDate, e.title, e.destination, e.reward, e.status, " +
            "(6371 * ACOS(COS(RADIANS(:latitude)) * COS(RADIANS(e.latitude)) " +
            "* COS(RADIANS(e.longitude) - RADIANS(:longitude)) " +
            "+ SIN(RADIANS(:latitude)) * SIN(RADIANS(e.latitude)))) as distance) " +
            "FROM Errand e " +
            "WHERE " +
            "(6371 * ACOS(COS(RADIANS(:latitude)) * COS(RADIANS(e.latitude)) " +
            "* COS(RADIANS(e.longitude) - RADIANS(:longitude)) " +
            "+ SIN(RADIANS(:latitude)) * SIN(RADIANS(e.latitude)))) > :cursor " +
            "ORDER BY distance")
    List<ErrandDistanceListDto> findErrandByDistance(@Param("latitude") double latitude, @Param("longitude") double longitude, @Param("cursor") double cursor);


    @Query("SELECT new com.pknuErrand.appteam.dto.errand.ErrandDistanceListDto(" +
            "e.orderNo, e.errandNo, e.createdDate, e.title, e.destination, e.reward, e.status, " +
            "(6371 * ACOS(COS(RADIANS(:latitude)) * COS(RADIANS(e.latitude)) " +
            "* COS(RADIANS(e.longitude) - RADIANS(:longitude)) " +
            "+ SIN(RADIANS(:latitude)) * SIN(RADIANS(e.latitude)))) as distance) " +
            "FROM Errand e " +
            "WHERE " +
            "(e.status = :status) AND " +
            "(6371 * ACOS(COS(RADIANS(:latitude)) * COS(RADIANS(e.latitude)) " +
            "* COS(RADIANS(e.longitude) - RADIANS(:longitude)) " +
            "+ SIN(RADIANS(:latitude)) * SIN(RADIANS(e.latitude)))) > :cursor " +
            "ORDER BY distance")
    List<ErrandDistanceListDto> findErrandByStatusAndDistance(@Param("latitude") Double latitude, @Param("longitude") Double longitude, @Param("cursor") double cursor, @Param("status") Status status);
}

