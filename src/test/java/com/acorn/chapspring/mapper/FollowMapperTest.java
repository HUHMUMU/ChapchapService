package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.FollowDto;
import com.acorn.chapspring.dto.UserDto;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class FollowMapperTest {
    @Autowired
    private FollowMapper followMapper;

    private FollowDto follow;
    private UserDto user;

    @Test
    void findByFromId() {
        List<UserDto> following=followMapper.findByFromId("admin");
        System.out.println(following);
    }

    @Test
    void findByToId() {
        List<UserDto> follower=followMapper.findByToId("user01");
        System.out.println(follower);
    }

    @Test
    void deleteByFromIdAndToId() {
//        follow=new FollowDto();
//        follow.setFromId("admin");
//        follow.setToId("user02");
//        int delete=followMapper.deleteByFromIdAndToId(follow);
//        assertEquals(delete,1);
    }

    @Test
    void insertOne() {
//        follow=new FollowDto();
//        follow.setFromId("admin");
//        follow.setToId("user02");
//        int add= followMapper.insertOne(follow);
//        assertEquals(add,1);
    }

    @Test
    void findByToIdAndFromIdIsLoginUserId() {

    }
}