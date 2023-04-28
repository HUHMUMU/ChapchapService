package com.acorn.chapspring.mapper;
import com.acorn.chapspring.dto.WaitingDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface WaitingMapper {

    List<WaitingDto> getWaitingList(); // 가게에 현재 등록된 모든 웨이팅 리스트
    WaitingDto getFastWaiting(int id, int waitNum); // 등록한 유저보다 빠른 대기순서를 가진 유저의 팀 목록 보여줄 용도
    int addWaiting(WaitingDto waitingDto); // 웨이팅 등록 시 대기열에 추가 및 대기 번호 생성
    int modifyWaiting(WaitingDto waitingDto); // 웨이팅 등록 후 유저가 인원 수정
    int deleteWaiting(int id, int waitingNum); // 웨이팅 등록 후 유저가 취소

    List<WaitingDto> getWaitingList(int waitNum, int storeNum);
}