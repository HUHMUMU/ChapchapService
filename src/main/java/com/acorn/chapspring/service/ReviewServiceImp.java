package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewsDto;
import com.acorn.chapspring.mapper.ReviewMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class ReviewServiceImp implements ReviewService{
    private ReviewMapper reviewMapper;
    @Override//3.유저 작성 리뷰 리스트
    public List<ReviewsDto> reviewed(String loginUserId){
//        userMapper.setLoginUserId(loginUserId);
        List<ReviewsDto> list=reviewMapper.findAllReviewed(loginUserId);
        return list;
    }

    @Override
    @Transactional
    public int register(ReviewsDto reviews) {
        int register=reviewMapper.insertReview(reviews);
        return register;
    }

    @Override
    @Transactional
    public int remove(int reviewNum) {
        int remove=reviewMapper.deleteReview(reviewNum);
        return remove;
    }
}
