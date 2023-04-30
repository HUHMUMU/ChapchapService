package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChatRoomDto;
import com.acorn.chapspring.mapper.ChatRoomMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ChatRoomServiceImp implements ChatRoomService{
    //채팅방 리스트
    private ChatRoomMapper chatRoomMapper;
    @Override
    public List<ChatRoomDto> list() {
        List<ChatRoomDto> list = chatRoomMapper.findAll();
        return list;
    }

    //채팅방 등록
    @Override
    public int register(ChatRoomDto chatRoomDto) {
        int register=chatRoomMapper.insertOne(chatRoomDto);
        return register;
    }

    @Override
    public int modify(ChatRoomDto chatRoomDto) {
        return 0;
    }

    @Override
    public int remove(int crId) {
        return 0;
    }
}
