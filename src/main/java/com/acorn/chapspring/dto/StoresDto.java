package com.acorn.chapspring.dto;

import lombok.Data;

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
    private String sRstatus;
    private boolean parking;
    private boolean wifi;
    private boolean toilet;
    private boolean smokingroom;
    private boolean babychair;
}
