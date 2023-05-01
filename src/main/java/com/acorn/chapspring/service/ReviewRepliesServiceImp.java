package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewRepliesDto;
import com.acorn.chapspring.mapper.ReviewRepliesMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class ReviewRepliesServiceImp implements ReviewRepliesService{
    private ReviewRepliesMapper reviewRepliesMapper;

    @Override
    public ReviewRepliesDto findRepliesByReview(int reviewNum) {
        return reviewRepliesMapper.findByReview(reviewNum);
    }

    @Override
    public int removeReply(int reviewNum) {
        return reviewRepliesMapper.deleteReply(reviewNum);
    }
}
