package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface ReviewMapper {
    List<ReviewsDto> findReviewByStore(int storeNum); //가게별 리뷰
    int countReviewByStore(int storeNum); //가게별 리뷰수

    List<ReviewsDto> findAllReviewed(String userId);
}
