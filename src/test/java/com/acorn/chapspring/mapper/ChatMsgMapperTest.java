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
        chatMsgDto.setUserId("user05");
        chatMsgDto.setContent("자~ 들어와랑~ ");
        chatMsgDto.setStatus(ChatMsgDto.Status.CHAT);
        chatMsgMapper.insertOne(chatMsgDto);
    }

    @Test
    void findByCrId() {
        chatMsgMapper.findByCrId(2);
    }

    @Test
    void findByCrIdAndGraterThanPostTime() {
        chatMsgMapper.findByCrIdAndGraterThanPostTime(2,"2023-04-26 15:25:00");
    }
}