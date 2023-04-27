package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChatMsgDto;
import com.acorn.chapspring.dto.ChatRoomDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChatMsgMapper {
    //메세지 보낸다(insert)
    int insertOne(ChatMsgDto chatMsgDto);
    List<ChatRoomDto> findBycrId(int crId);
    List<ChatRoomDto> findByCrIdAndGraterThanPostTime(int crId, String postTime);
}
