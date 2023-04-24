package com.acorn.chapspring.dto;
import lombok.Data;
@Data
public class WaitingDto {
    private String userId; // 유저의 id를 한 개의 팀으로 설정
    private int waitingNum; // 웨이팅 대기번호 고유값
    private int userPeople; // 인원
    private int waitNum; // 대기번호
    private String enterStatus; // 대기상태
}


// 보완 수정해야함!