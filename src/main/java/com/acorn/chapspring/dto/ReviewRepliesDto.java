package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.Date;

@Data
@JsonIgnoreProperties({"handler"})
public class ReviewRepliesDto {
    private int rrNum; //PK (auto increment) 대댓글 번호
    private int reviewNum; //FK 리뷰 번호
    private Date postDate; //작성날짜
    private String content; //작성내용
}
