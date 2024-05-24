package com.pknuErrand.appteam.dto.errand.saveDto;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Getter
public class ErrandSaveRequestDto { // to Entity
    
    /**
     *  게시글 등록하는 member의 정보는 jwt에서 추출
     */

    @NotBlank(message = "등록일을 입력하세요.")
    private String createdDate; // 등록한 date

    @NotBlank(message = "제목을 입력하세요.")
    private String title;

    @NotBlank(message = "도착지를 입력하세요.")
    private String destination;

    @NotNull(message = "latitude를 입력하세요.")
    private double latitude;

    @NotNull(message = "longitude를 입력하세요.")
    private double longitude;

    @NotBlank(message = "마감시간을 입력하세요.")
    private String due; // 몇시까지?

    @NotBlank(message = "상세내용을 입력하세요.")
    private String detail;

    @PositiveOrZero(message = "보수금액을 입력하세요.")
    private int reward;

    @NotNull(message = "현금인지 아닌지 입력하세요.")
    private Boolean isCash;

    // private Status status;

    /**
     *  request 받을 때 (save하려고 정보를 받을 때) 담당자 정보는 가져올 필요가 없다.
     */
}
