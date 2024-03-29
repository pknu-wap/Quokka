package com.pknuErrand.appteam.domain.errand;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
@NoArgsConstructor
@Entity(name = "errand")
public class Errand {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column
    private long errandNo;

    @Column
    private long orderNo;

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
    private boolean isCash;

    @Column
    @Enumerated(EnumType.STRING)
    private Status status;

    @Column
    private long erranderNo; // 심부름꾼의 pk
}
