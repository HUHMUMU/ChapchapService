package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewsDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ReviewMapperTest {
    @Autowired
    private ReviewMapper reviewMapper;

    @Test
    void findReviewByStore() {
        List<ReviewsDto> reviews=reviewMapper.findReviewByStore(1);
        System.out.println("reviews = " + reviews);
        assertNotNull(reviews);
    }

    @Test
    void findAllReviewed() {
    }
}