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
    ReviewLikesDto checkLikeByUser(@Param("reviewNum") int reviewNum, @Param("userId") String userId);
    int insertReviewLike(ReviewLikesDto reviewLikes);
    int deleteReviewLike(@Param("reviewNum") int reviewNum, @Param("userId") String userId);
}
