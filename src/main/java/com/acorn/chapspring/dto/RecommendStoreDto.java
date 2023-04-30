package com.acorn.chapspring.dto;

import lombok.Data;

@Data
public class RecommendStoreDto {
    private int recommendStoreNum;
    private String comment;
    private String userId;
    private int storeNum;

    private String storeName;//조인용 변수

    //테스트 변수----------------
//    private int recommendNum;
    //-----------------------
}
