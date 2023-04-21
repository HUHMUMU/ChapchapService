package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.UserDto;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class UserMapperTest {
    @Autowired

    private UserMapper userMapper;
    private static UserDto user;
    @Test
    @Order(1)
    void findByUserId() {
        //user=new UserDto();
        UserDto findUser=userMapper.findByUserId("user01");
        System.out.println("findUser : "+findUser);
        assertNotNull(findUser);
    }


    @Test
    @Order(2)
    void findByUserIdAndPw() {
        user=new UserDto();
        user.setUserId("user01");
        user.setPw("password123");
        UserDto findUser=userMapper.findByUserIdAndPw(user);
        System.out.println("findUser : "+findUser);
        assertNotNull(findUser);
    }

    @Test
    @Order(3)
    void findByUserIdByEmailAndName() {
        user=new UserDto();
        user.setName("김철수");
        user.setEmail("chulsoo@example.com");
        String userId=userMapper.findByUserIdByEmailAndName(user);
        System.out.println("Id : "+userId);

    }

    @Test
    @Order(4)
    void updateOne() {
        user=new UserDto();
        user.setUserId("user01");
        user.setNickname("철");
        user.setPw("password111");
        user.setAddress("서울특별시");
        user.setDetailAddress("송파구");
        user.setEmail("chul@gmail.com");
        user.setBirth("1996-04-04");
        user.setGender("MALE");
        int update= userMapper.updateOne(user);
        UserMapperTest.user=userMapper.findByUserId(user.getUserId());
        System.out.println("수정된 유저 정보 :"+UserMapperTest.user);
        assertEquals(update,1);
    }

    @Test
    @Order(4)
    void insertOne() {
        user=new UserDto();
        user.setUserId("user21");
        user.setPw("password222");
        user.setName("강석정");
        user.setNickname("밀다라심경");
        user.setBirth("1996-04-04");
        user.setGender("MALE");
        user.setAddress("서울특별시");
        user.setDetailAddress("송파구");
        user.setEmail("tlssua6985@gmail.com");
        int insert=userMapper.insertOne(user);
        UserMapperTest.user=userMapper.findByUserId(user.getUserId());
        System.out.println("등록된 유저 정보 : "+UserMapperTest.user);
        assertEquals(insert,1);
    }

    @Test
    void deleteByUserIdAndPw() {
        user=new UserDto();
        user.setUserId("user21");
        user.setPw("password222");
        int delete= userMapper.deleteByUserIdAndPw(user);
        assertEquals(delete,1);
    }
    @Test
    public void memberIdChk() throws Exception {
        String id="test01"; //존재하는 아이디
        String idx="test02"; //존재하지 않는 아이디
        userMapper.idCheck(id);
        userMapper.idCheck(idx);
    }
    @Test
    public void nickNameChk() throws Exception {
        String nick="밀다라심경"; //존재하는 아이디
        String nickx="뚱이씨"; //존재하지 않는 아이디
        userMapper.nickName_Check(nick);
        userMapper.nickName_Check(nickx);
    }
    @Test
    public void emailChk() throws Exception {
        String email="test03@gmail.com";
        String emailx="fhrzl550@gmail.com";
        userMapper.email_Check(email);
        userMapper.email_Check(emailx);
    }
}