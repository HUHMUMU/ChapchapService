package com.acorn.chapspring.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class ReviewLikeServiceImpTest {
    @Autowired
    private ReviewLikeService reviewLikeService;

    @Test
    void removeLikeByReview() {
        int remove=reviewLikeService.removeLikeByReview(93);
        System.out.println("remove = " + remove);
    }
}