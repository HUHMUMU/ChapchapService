package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewLikesDto;
import com.acorn.chapspring.mapper.ReviewLikeMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class ReviewLikeServiceImp implements ReviewLikeService{
    private ReviewLikeMapper reviewLikeMapper;
    @Override
    public ReviewLikesDto checkLikeByUser(int reviewNum, String userId) {
        return reviewLikeMapper.findByReviewAndUId(reviewNum, userId);
    }
    @Override
    public ReviewLikesDto checkLike(int reviewNum) {
        return reviewLikeMapper.countLikeByReview(reviewNum);
    }

    @Override
    public int registerLike(ReviewLikesDto reviewLikes) {
        return reviewLikeMapper.insertReviewLike(reviewLikes);
    }
    @Override
    public int modifyLike(ReviewLikesDto reviewLikes) {
        return reviewLikeMapper.updateReviewLike(reviewLikes);
    }
    @Override
    public int removeLike(ReviewLikesDto reviewLikes) {
        return reviewLikeMapper.deleteReviewLike(reviewLikes);
    }

    @Override
    public int removeLikeByReview(int reviewNum) {
        int remove=reviewLikeMapper.deleteReview(reviewNum);
        return remove;
    }

}
