package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewLikesDto;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

public interface ReviewLikeService {
    //유저가 좋아요 했는지 확인
    //좋아요 누르기
    //좋아요 취소
    ReviewLikesDto checkLikeByUser(@Param("reviewNum") int reviewNum, @Param("userId")String userId);
    ReviewLikesDto checkLike(int reviewNum);
    int registerLike(ReviewLikesDto reviewLikes);
    int modifyLike(ReviewLikesDto reviewLikes);
    int removeLike(ReviewLikesDto reviewLikes);
    int removeLikeByReview(@Param("reviewNum") int reviewNum);
}
