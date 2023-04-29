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
        return reviewLikeMapper.checkLikeByUser(reviewNum, userId);
    }
    @Override
    public int insertReviewLike(ReviewLikesDto reviewLikes) {
        return reviewLikeMapper.insertReviewLike(reviewLikes);
    }
    @Override
    public int deleteReviewLike(int reviewNum, String userId) {
        return reviewLikeMapper.deleteReviewLike(reviewNum, userId);
    }

}
