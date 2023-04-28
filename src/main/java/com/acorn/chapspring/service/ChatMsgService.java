package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChatMsgDto;

import java.util.List;

public interface ChatMsgService {
    //채팅방 메세지 전체 조회
    //채팅방 메세지 중에 마지막 조회한 내역 다음의 리스트
    //룸에서 메세지 보내기
    int register(ChatMsgDto chatMsgDto);
    List<ChatMsgDto> list(int crId);
    List<ChatMsgDto> list(int crId, String postTime);
}
