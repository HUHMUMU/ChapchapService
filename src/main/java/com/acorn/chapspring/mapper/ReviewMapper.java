package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface ReviewMapper {
    List<ReviewsDto> findReviewByStore(int store);

    List<ReviewsDto> findAllReviewed(String userId);
}