package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewsDto;

import java.util.List;

public interface ReviewService {
    List<ReviewsDto> reviewed(String userId);//유저 리뷰조회

    List<ReviewsDto> menuNames(int storeNum);
    int register(ReviewsDto reviews); //리뷰 등록
    int remove(int reviewNum); //리뷰 삭제
}
