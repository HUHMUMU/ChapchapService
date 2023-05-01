package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class StoresWaitingDto {
    private int adminWaiting; //PK 웨이팅
    private String closingTime; //웨이팅 마감시간
    private int maxPeople; //웨이팅 최대 인원수
    private boolean waitingOnoff; //웨이팅 on/off
    private int timeSetup; //웨이팅 시간 설정
    private String storeAds; //가게 홍보 url
    private int storeNum; //FK 가게 고유 번호
}
