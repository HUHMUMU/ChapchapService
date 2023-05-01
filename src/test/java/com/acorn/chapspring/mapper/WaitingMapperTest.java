package com.acorn.chapspring.mapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class WaitingMapperTest {
    @Autowired
    private WaitingMapper waitingMapper;
    @Test
    void findByWaitNum() {
    }

    @Test
    void getWaitingList() {
        waitingMapper.getWaitingList(1,"user10");
    }

    @Test
    void addWaiting() {
    }

    @Test
    void updateOne() {
    }

    @Test
    void deleteByWaitingNum() {
    }
}