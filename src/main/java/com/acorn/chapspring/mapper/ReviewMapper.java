package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewsDto;

import java.util.List;

public interface ReviewMapper {
    List<ReviewsDto> findReviewByStore(int store);
}
