package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties({"handler"})
public class RecommendStoreDto {
    private int recommendStoreNum;
    private String comment;
    private String userId;
    private int storeNum;

    private String storeName;//조인용 변수
    private List<MenuManagesDto> menuList;//가게 추천
    private int recommendMenu;

    //테스트 변수----------------
//    private int recommendNum;
    //-----------------------
}
