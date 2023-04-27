package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface ReviewMapper {
    List<ReviewsDto> findReviewByStore(int storeNum); //가게별 리뷰
    int countReviewByStore(int storeNum); //가게별 리뷰수
    int insertReview(ReviewsDto reviews); //리뷰 작성
    int deleteReview(int reviewNum);//리뷰 삭제

    List<ReviewsDto> findAllReviewed(String userId);
}
