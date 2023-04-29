package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewLikesDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ReviewLikeMapper {
    ReviewLikesDto countLikeByReview(int reviewNum); //리뷰당 좋아요 수
    ReviewLikesDto findByReviewAndUId(@Param("reviewNum") int reviewNum, @Param("userId") String userId);
    List<ReviewLikesDto> findLikeByReview(int reviewNum);
    int insertReviewLike(ReviewLikesDto reviewLikes);
    int updateReviewLike(ReviewLikesDto reviewLikes);
    int deleteReviewLike(ReviewLikesDto reviewLikes);
}
