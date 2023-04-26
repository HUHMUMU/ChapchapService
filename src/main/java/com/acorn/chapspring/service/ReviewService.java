package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewsDto;

import java.util.List;

public interface ReviewService {
    List<ReviewsDto> reviewed(String userId);//유저 리뷰조회
}
