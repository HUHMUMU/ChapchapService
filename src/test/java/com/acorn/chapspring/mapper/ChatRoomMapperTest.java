package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChatRoomDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ChatRoomMapperTest {
    @Autowired
    private ChatRoomMapper chatRoomMapper;
    @Test
    void findAll() {
        chatRoomMapper.findAll();
    }

    @Test
    void insertOne() {
        ChatRoomDto chatRoomDto=new ChatRoomDto();
        chatRoomDto.setUserId("fhrzl550");
        chatRoomDto.setName("뚱이아저씨 수다방~");
        chatRoomDto.setProfileImg("/public/img/logo.png");
        chatRoomMapper.insertOne(chatRoomDto);
    }
}