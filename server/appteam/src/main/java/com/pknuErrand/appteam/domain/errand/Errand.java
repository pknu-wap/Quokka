package com.pknuErrand.appteam.domain.errand;


import com.pknuErrand.appteam.Enum.ErrandStatus;
import com.pknuErrand.appteam.domain.member.Member;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@Entity(name = "Errand")
public class Errand {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column
    private long errandNo;


    @ManyToOne
    @JoinColumn
    private Member orderNo; // 심부름 시킨사람의 pk

    @Column
    private String createdDate; // 등록한 date

    @Column
    private String title;

    @Column
    private String destination;

    @Column
    private double latitude;

    @Column
    private double longitude;

    @Column
    private Timestamp due; // 몇시까지?

    @Column
    private String detail;

    @Column
    private int reward;

    @Column
    private Boolean isCash;

    @Column
    @Enumerated(EnumType.STRING)
    private ErrandStatus errandStatus;

    @ManyToOne
    @JoinColumn
    private Member erranderNo; // 심부름꾼

    public void changeErrandStatusAndSetErrander(ErrandStatus errandStatus, Member errander) {
        this.errandStatus = errandStatus;
        erranderNo = errander;
    }

    public void updateErrand(String createdDate, String title, String destination,
                             double latitude, double longitude, Timestamp due, String detail,
                             int reward, Boolean isCash) {
        this.createdDate = createdDate;
        this.title = title;
        this.destination = destination;
        this.latitude = latitude;
        this.longitude = longitude;
        this.due = due;
        this.detail = detail;
        this.reward = reward;
        this.isCash = isCash;
    }
    public Errand(Member orderNo, String createdDate, String title, String destination,
                  double latitude, double longitude, Timestamp due, String detail,
                  int reward, Boolean isCash, ErrandStatus errandStatus, Member erranderNo) {
        this.orderNo = orderNo;
        this.createdDate = createdDate;
        this.title = title;
        this.destination = destination;
        this.latitude = latitude;
        this.longitude = longitude;
        this.due = due;
        this.detail = detail;
        this.reward = reward;
        this.isCash = isCash;
        this.errandStatus = errandStatus;
        this.erranderNo = erranderNo;
    }
}
