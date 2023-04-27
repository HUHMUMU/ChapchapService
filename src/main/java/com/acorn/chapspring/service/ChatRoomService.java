package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChatRoomDto;

import java.util.List;

public interface ChatRoomService {
    //채팅방 리스트, 채팅방 등록, 채팅방 수정, 채팅방 삭제

    //채팅방 리스트,
    List<ChatRoomDto> list();
    //채팅방 등록
    int register(ChatRoomDto chatRoomDto);
    int modify(ChatRoomDto chatRoomDto);
    int remove(int crId);
}
