package com.acorn.chapspring.dto;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.Date;

@Data
@JsonIgnoreProperties({"handler"})
public class UsersWaitingDto {
    private int storeNum; //가게의 고유번호(이름이 같은 가게를 구분하기 위함)
    private int waitingNum; // 나중에 유저가 조회할 때 구분이 가능한 웨이팅 대기번호 고유값
    private String userId; // 유저의 id를 한 개의 팀으로 설정
    private int userPeople; // 유저가 입력하는 대기인원
    private int maxPeople; // 사장님이 등록해놓은 팀당 최대인원
    private int waitNum; // 유저가 대기 등록을 누르면 해당 가게에서만 사용되는 대기번호
    private Date waitingDate; //웨이팅 날짜
    private String enterStatus; // 대기상태
    private int addWaitNum; // 대기 등록을 누르면 해당 가게에서만 사용되는 대기열에 순서대로 번호 추가
    private int addWaitingNum; // 다른가게에서 웨이팅 등록을 하게되면  고유값 추가?
    private String startTime; // 유저가 웨이팅 대기 등록을 한 시간
    private int timeSetup; // 사장님이 등록해 놓은 팀당 기본 대기시간
    private String storeAds; // 사장님이 등록해 놓은 홍보 url
}
