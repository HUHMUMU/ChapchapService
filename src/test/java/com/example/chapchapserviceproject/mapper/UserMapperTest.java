package com.example.chapchapserviceproject.mapper;

import com.example.chapchapserviceproject.dto.UserDto;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class UserMapperTest {
    @BeforeAll
    static void init() {} //모든 테스트 실행전에 실행(초기화)
    @AfterAll
    static void detory() {}

    @Autowired
    private UserMapper userMapper;

    private static UserDto user;
    @Test
    @Order(1) //모든 것들 중 첫번째로 실행
    void insertOne() {
        user = new UserDto();
        user.setUserId("test01");
        user.setNickName("뚱이 아저씨");
        user.setPw("1234");
        user.setName("뚱이");
        user.setBirth("1993-02-28");
        user.setGender("MALE");
        user.setAddress("서울시 강남구");
        user.setDetailAddress("압구정동");
        user.setEmail("test01@gmail.com");
        int insertOne=userMapper.insertOne(user);
        Assertions.assertEquals(insertOne,1);

    }
}
