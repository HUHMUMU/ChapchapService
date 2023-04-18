package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class ReviewDto {
    private int reviewNum;
    private String content;
    private String comment;
    private String img;
    private Date date;
    private int star;
    private String rrStatus;
    private String userId;
    private int storeNum;

}
