package com.acorn.chapspring.dto;

import lombok.Data;

import java.time.LocalTime;
import java.util.Date;
import java.util.List;

@Data
public class ChapstorysDto {
    private int chapNum; // PK
    private String title;
    private String content;
    private int viewcount;
    private Date date;
    private int likes;
    private String profile;
    private String mainImg;
    private Date updateTime;
    private String userId; // FK
    private String chsRstatus;
    private UserDto user;
    private List<ChapstoryimgsDto> chapstoryimgs; // 1:N = chapstory : chapstoryimgs
}
