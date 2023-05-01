package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.UsersWaitingDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class UsersWaitingMapperTest {
    @Autowired
    UsersWaitingMapper usersWaitingMapper;

    @Test
    void findWaitingNum() {
        UsersWaitingDto waiting=usersWaitingMapper.findWaitingNum(1);
        System.out.println("waiting = " + waiting);
    }
}