package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChatMsgDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ChatMsgMapperTest {
    @Autowired
    private ChatMsgMapper chatMsgMapper;

    @Test
    void insertOne() {
        ChatMsgDto chatMsgDto=new ChatMsgDto();
        chatMsgDto.setCrId(2);
        chatMsgDto.setUserId("user09");
        chatMsgDto.setContent("닉네임 가져와 진다~ ");
        chatMsgDto.setStatus(ChatMsgDto.Status.ENTER);
        chatMsgMapper.insertOne(chatMsgDto);
    }

    @Test
    void findByCrId() {
        chatMsgMapper.findByCrId(5);
    }

    @Test
    void findByCrIdAndGraterThanPostTime() {
        chatMsgMapper.findByCrIdAndGraterThanPostTime(5,"2023-04-26 15:25:00");
    }
}