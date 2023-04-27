package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ReviewRepliesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;

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

    @Test
    void insertReply() {
        ReviewRepliesDto replies=new ReviewRepliesDto();
        replies.setReviewNum(71);
        Date LocalDate = new Date();
        replies.setPostDate(LocalDate);
        replies.setContent("테스트 리플");
        int insertOne=reviewRepliesMapper.insertReply(replies);
        System.out.println("insertOne = " + insertOne);
    }

    @Test
    void deleteReply() {
        int deleteOne=reviewRepliesMapper.deleteReply(11);
        System.out.println("deleteOne = " + deleteOne);
    }
}