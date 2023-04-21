package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class ChapDealDto {
    private int eventNum; //pk 
    private int storeNum; //fk 가게 번호
    private String eventTitle; //이벤트 제목
    private String eventCondition; //이벤트 조건
    private String eventReward; //이벤트 보상
    private String eventImg; //이벤트 이미지
    private Date eventStart; //이벤트 시작 날짜
    private Date eventEnd; //이벤트 마감 날짜

    private String storeName; //가게 이름

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }
}
