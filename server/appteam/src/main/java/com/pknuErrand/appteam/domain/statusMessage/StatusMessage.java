package com.pknuErrand.appteam.domain.statusMessage;

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
public class StatusMessage {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column
    private long statusNo;

    @ManyToOne
    @JoinColumn
    private Member erranderNo; // 심부름 꾼

    @ManyToOne
    @JoinColumn
    private Errand errandNo; // 심부름 번호

    @Column
    private String contents; // 현황 정보

    @Column
    private LocalDateTime created;

    @Builder
    public StatusMessage(Member erranderNo, Errand errandNo, String contents) {
        this.erranderNo = erranderNo;
        this.errandNo = errandNo;
        this.contents = contents;
        this.created = LocalDateTime.now();
    }

}
