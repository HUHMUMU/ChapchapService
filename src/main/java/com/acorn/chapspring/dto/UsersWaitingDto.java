package com.acorn.chapspring.dto;
import lombok.Data;



@Data
public class UsersWaitingDto {
    private String userId; // 유저의 id를 한개의 팀으로 설정
    private int waiting_num; //웨이팅 대기번호 고유값
    private int userPeople; //인원
    private int waitNum; //대기번호
    private String enterStatus; // 대기상태
}
