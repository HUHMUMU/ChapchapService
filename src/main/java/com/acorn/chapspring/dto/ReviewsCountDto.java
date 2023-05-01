package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties({"handler"})
public class ReviewsCountDto {
    private  String storeNum; // 리뷰수가 제일많은 가게 넘버
    private int reviewCount; // 리뷰수 카운트하기
    private StoretypesDto storeTypes; //가게 타입 체크하기(음식점, 카페, 술집)
}
