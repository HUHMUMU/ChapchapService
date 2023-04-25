package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class ReviewsDto {
    private int reviewNum;
    private String content;
    private String comment;
    private String img;
    private Date date;
    private int star;
    private String rrStatus;
    private String userId;
    private int storeNum;
    private int menuNum;
    private String storeName; //가게 이름 끌어오기
    private String mainImg;// 가게 대표 사진 끌어오기
    private UserDto userInfo; //유저 정보 가져오기
}
