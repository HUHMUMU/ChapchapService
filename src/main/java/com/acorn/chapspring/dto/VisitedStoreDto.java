package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class VisitedStoreDto {
    private int visitedStoreOrder;
    private Date visitedDate;
    private String userId;
    private String storeName;
    private String address;

//    테스트 단계
    private int listNum;//유저 리스트 고유 번호(데이터베이스에 없음!)
}
