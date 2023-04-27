package com.acorn.chapspring.dto;

import lombok.Data;

import java.time.LocalTime;
import java.util.Date;
import java.util.List;

@Data
public class ChapstorysDto {
    private int chapNum; // PK
    private String title; // 제목
    private String content; //내용
    private int viewcount; //조휘수
    private Date postTime; //등록날짜
    private String profile;
    private String mainImg; //썸네일
    private Date updateTime; //수정날짜
    private String userId; // FK
    private String chsRstatus; // 공개상태
    private UserDto user;
    private int likeCnt;//해당 게시글에 라이크를 한 수
    private List<ChapstoryimgsDto> chapstoryimgs; // 1:N = chapstory : chapstoryimgs
}
