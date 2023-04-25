package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.List;

@Data
public class StoresDto {
    private int storeNum;
    private String storeName;
    private String detailInfo;
    private String shortInfo;
    private String madein;
    private String address;
    private String mainImg;
    private String opentime;
    private String lastorder;
    private String waitingClosetime;
    private String blogurl;
    private String youtubeurl;
    private String facebookurl;
    private String instaurl;
    private String tvshow;
    private String sRstatus; //enum('공개','심사','비공개')
    private boolean parking;
    private boolean wifi;
    private boolean toilet;
    private boolean smokingroom;
    private boolean babychair;

    private List<MenuManagesDto> menuList; //메뉴들 가져오기
    private List<ChapDealDto> chapDealList; //챱딜 이벤트 가져오기
    private List<ReviewsDto> reviewList; //리뷰들 가져오기
    private StoreManagesDto storeCall; //가게 전화번호 가져오기

    private int categoryNum; // 카테고리 번호
    private int jjimCount; // 찜 갯수
    private int reviewCount; // 리뷰 갯수
    private double averageStar; // 평균 별점

}
