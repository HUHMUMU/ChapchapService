package com.acorn.chapspring.dto;

import lombok.Data;

import java.util.Date;

@Data
public class ChatRoomDto {
    private int crId; //pk auto increment
    private String userId; //fk users user_id
    private String name; //채팅방 이름
    private String description; //채팅방 설명
    private Date postTime;
    private Date updateTime;
    private String profileImg;
}
