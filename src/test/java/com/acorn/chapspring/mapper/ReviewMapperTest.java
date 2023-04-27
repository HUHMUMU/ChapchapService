package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewsDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.Instant;
import java.time.LocalDate;
import java.util.Date;
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

    @Test
    void countReviewByStore() {
        int count=reviewMapper.countReviewByStore(1);
        System.out.println("count = " + count);
    }

    @Test
    void insertReview() {
        ReviewsDto reviews=new ReviewsDto();
        reviews.setContent("테스트 리뷰 내용");
        reviews.setComment("테스트 한줄평");
        reviews.setImg("test.jpg");
        Date LocalDate = new Date();
        reviews.setDate(LocalDate);
        reviews.setStar(4);
        reviews.setRrStatus("공개");
        reviews.setUserId("user10");
        reviews.setStoreNum(1);
        reviews.setMenuNum(1);
        int insertOne=reviewMapper.insertReview(reviews);
        System.out.println("insertOne = " + insertOne);
    }

    @Test
    void deleteReview() {
        int deleteOne = reviewMapper.deleteReview(72);
        System.out.println("deleteOne = " + deleteOne);
    }
}