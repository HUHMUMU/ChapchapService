package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewLikesDto;

public interface ReviewLikeService {
    //유저가 좋아요 했는지 확인
    //좋아요 누르기
    //좋아요 취소
    ReviewLikesDto checkLikeByUser(int reviewNum, String userId);
    int insertReviewLike(ReviewLikesDto reviewLikes);
    int deleteReviewLike(int reviewNum, String userId);
}
