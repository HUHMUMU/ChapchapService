package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class HolidaysDto {
    private int holiNum; // pk
    private int storeNum; // fk 가게 고유 번호
    private String week; //요일 enum('월','화','수','목','금','토','일')
    private Date date; //날짜
    private int regular; //정규(1)/비정규(0)
}
