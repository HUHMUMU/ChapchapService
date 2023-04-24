package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class ReviewRepliesDto {
    private int rrNum;
    private int reviewNum;
    private Date postDate;
    private String content;
}
