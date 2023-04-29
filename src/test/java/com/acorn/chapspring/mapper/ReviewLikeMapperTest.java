package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewLikesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ReviewLikeMapperTest {
    @Autowired
    ReviewLikeMapper reviewLikeMapper;

    @Test
    void countLikes() {
        ReviewLikesDto countLike=reviewLikeMapper.countLikeByReview(1);
        System.out.println("countLike = " + countLike);
        assertNotNull(countLike);
    }
}