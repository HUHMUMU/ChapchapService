package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.FollowDto;
import com.acorn.chapspring.mapper.FollowMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class FollowServiceTest {
    @Autowired
    private FollowMapper followMapper;
    @Test
    void remove() {
        FollowDto follow=new FollowDto();
        follow.setFromId("admin");
        follow.setToId("user07");
        int remove=followMapper.deleteByFromIdAndToId(follow);
        assertEquals(remove,1);
    }

    @Test
    void register() {
    }
}