package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewRepliesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ReviewRepliesMapperTest {
    @Autowired
    private ReviewRepliesMapper reviewRepliesMapper;

    @Test
    void findByReview() {
        ReviewRepliesDto replies=reviewRepliesMapper.findByReview(1);
        System.out.println("replies = " + replies);
        assertNotNull(replies);
    }
}