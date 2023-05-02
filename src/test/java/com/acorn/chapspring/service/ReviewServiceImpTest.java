package com.acorn.chapspring.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class ReviewServiceImpTest {
    @Autowired
    private ReviewService reviewService;

    @Test
    void remove() {
        int review=reviewService.remove(71);
        System.out.println("review = " + review);
    }
}