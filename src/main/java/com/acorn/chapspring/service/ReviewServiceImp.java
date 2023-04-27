package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewsDto;
import com.acorn.chapspring.mapper.ReviewMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

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

}
