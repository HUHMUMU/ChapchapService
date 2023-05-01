package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class ReviewLikesDto {
    private int rlId; //PK (auto increment)
    private String rlStatus; //좋아요 싫어요 enum('LIKE', 'BAD')
    private String userId; //FK 유저 아이디
    private int reviewNum; //FK 리뷰 고유번호

    private int likeCount;
    private int badCount;
}
