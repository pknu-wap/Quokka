package com.pknuErrand.appteam.domain.status;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.domain.member.Member;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@Entity(name = "Status")
public class Status {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column
    private long statusNo;

    @ManyToOne
    @JoinColumn
    private Member erranderNo; // 심부름 꾼

    @ManyToOne
    @JoinColumn
    private Errand errandNo;

    @Column
    private String contents; // 현황 정보

    @Column
    private LocalDateTime created;

    @Builder
    public Status(Member erranderNo, Errand errandNo, String contents) {
        this.erranderNo = erranderNo;
        this.errandNo = errandNo;
        this.contents = contents;
        this.created = LocalDateTime.now();
    }

}
