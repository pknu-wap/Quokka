package com.pknuErrand.appteam.domain.errand;

import com.pknuErrand.appteam.domain.member.Member;
import jakarta.persistence.*;

import java.sql.Timestamp;

public class ErrandBuilder {

    private Member orderNo;
    private Timestamp createdDate;
    private String title;
    private String destination;
    private double latitude;
    private double longitude;
    private Timestamp due;
    private String detail;
    private int reward;
    private boolean isCash;
    private Status status;
    private Member erranderNo;

    public ErrandBuilder orderNo(Member orderNo) {
        this.orderNo = orderNo;
        return this;
    }

    public ErrandBuilder createdDate(Timestamp createdDate) {
        this.createdDate = createdDate;
        return this;
    }

    public ErrandBuilder title(String title) {
        this.title = title;
        return this;
    }

    public ErrandBuilder destination(String destination) {
        this.destination = destination;
        return this;
    }

    public ErrandBuilder latitude(double latitude) {
        this.latitude = latitude;
        return this;
    }

    public ErrandBuilder longitude(double longitude) {
        this.longitude = longitude;
        return this;
    }

    public ErrandBuilder due(Timestamp due) {
        this.due = due;
        return this;
    }

    public ErrandBuilder detail(String detail) {
        this.detail = detail;
        return this;
    }

    public ErrandBuilder reward(int reward) {
        this.reward = reward;
        return this;
    }

    public ErrandBuilder isCash(boolean isCash) {
        this.isCash = isCash;
        return this;
    }

    public ErrandBuilder status(Status status) {
        this.status = status;
        return this;
    }

    public ErrandBuilder erranderNo(Member erranderNo) {
        this.erranderNo = erranderNo;
        return this;
    }

    public Errand build() {
        return new Errand(orderNo, createdDate, title, destination, latitude, longitude, due, detail, reward, isCash, status, erranderNo);
    }
}
