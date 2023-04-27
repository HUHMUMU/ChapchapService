package com.acorn.chapspring.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class ChatMsgDto {
    @JsonProperty("cmId")
    private int cmId; //pk
    @JsonProperty("crId")
    private int crId; //fk chat_rooms cr_id
    @JsonProperty("userId")
    private String userId; //fk users user_id;
    private String content; //메세지 내용
    private String status; //메세지 상세
    @JsonFormat(timezone = "Asia/Seoul",pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonProperty("postTime")
    //pattern = "yyyy-MM-dd HH:mm:ss : 자바스크립트로 패턴을 사용할 수 있다.
    private Data postTime; //등록 시간
}
