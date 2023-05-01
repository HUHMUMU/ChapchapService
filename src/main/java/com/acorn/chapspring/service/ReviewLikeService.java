package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewLikesDto;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

public interface ReviewLikeService {
    ReviewLikesDto checkLikeByUser(@Param("reviewNum") int reviewNum, @Param("userId")String userId); //유저가 좋아요 했는지 확인
    ReviewLikesDto checkLike(int reviewNum); //좋아요 보기
    int registerLike(ReviewLikesDto reviewLikes); //좋아요 등록
    int modifyLike(ReviewLikesDto reviewLikes); //좋아요 상태 바꾸기
    int removeLike(ReviewLikesDto reviewLikes); //좋아요 취소
    int removeLikeByReview(@Param("reviewNum") int reviewNum); //리뷰 삭제시 좋아요 삭제
}
