package com.pknuErrand.appteam.domain.errand;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
@Entity
public class ErrandCompletionStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(mappedBy = "errandCompletionStatus")
    @JoinColumn
    private Errand errand;

    @Column(nullable = false)
    private boolean orderConfirmed;

    @Column(nullable = false)
    private boolean erranderConfirmed;

    public ErrandCompletionStatus(Errand errand) {
        this.errand = errand;
        orderConfirmed = false;
        erranderConfirmed = false;
    }

    public void setErranderConfirmed(boolean flag) {
        erranderConfirmed = flag;
    }

    public void setOrderConfirmed(boolean flag){
        orderConfirmed = flag;
    }
}
