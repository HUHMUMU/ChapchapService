package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewRepliesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class ReviewRepliesServiceImpTest {
    @Autowired
    private ReviewRepliesService reviewRepliesService;
    @Test
    void removeReply() {
        int replies=reviewRepliesService.removeReply(12);
        System.out.println("replies = " + replies);
    }

    @Test
    void findRepliesByReview() {
        ReviewRepliesDto replies=reviewRepliesService.findRepliesByReview(1);
        System.out.println("replies = " + replies);
    }
}