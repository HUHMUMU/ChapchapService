package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChatMsgDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ChatMsgMapper {
    //메세지 보낸다(insert)
    int insertOne(ChatMsgDto chatMsgDto);
    List<ChatMsgDto> findByCrId(int crId);
    List<ChatMsgDto> findByCrIdAndGraterThanPostTime(@Param("crId") int crId, @Param("postTime") String postTime);
}
