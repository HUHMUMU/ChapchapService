package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewLikesDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Mapper
@Repository
public interface ReviewLikeMapper {
    ReviewLikesDto countLikeByReview(int reviewNum); //리뷰당 좋아요 수
    ReviewLikesDto findByReviewAndUId(@Param("reviewNum") int reviewNum, @Param("userId") String userId);
    List<ReviewLikesDto> findLikeByReview(int reviewNum);//리뷰 별 좋아요 정보
    int insertReviewLike(ReviewLikesDto reviewLikes); //리뷰에 좋아요 등록
    int updateReviewLike(ReviewLikesDto reviewLikes); //리뷰에 좋아요 수정
    int deleteReviewLike(ReviewLikesDto reviewLikes);  //리뷰에 좋아요 삭제
    int deleteReview(@Param("reviewNum") int reviewNum); //리뷰 삭제시 좋아요도 삭제
}
