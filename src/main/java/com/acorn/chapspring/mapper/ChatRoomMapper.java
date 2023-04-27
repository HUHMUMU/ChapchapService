package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChatRoomDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChatRoomMapper {
    //채팅방 리스트
    List<ChatRoomDto> findAll();
    //채팅방 등록
    int insertOne(ChatRoomDto chatRoomDto);
}
