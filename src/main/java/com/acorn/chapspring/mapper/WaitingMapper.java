package com.acorn.chapspring.mapper;
import com.acorn.chapspring.dto.UsersWaitingDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Mapper
@Repository
public interface WaitingMapper {

    int getWaitingCount(int storeNum);
    int getPrevWaitingCount(int storeNum, Date waitingDate, int waitNum);

    UsersWaitingDto getWaitingByWaitNum(int storeNum, int waitNum);

    int findByStoreNumByWaitNumAsc(int storeNum, int waitNum);
    List<UsersWaitingDto> getWaitingList(); // 가게에 현재 등록된 모든 웨이팅 리스트
    UsersWaitingDto getFastWaiting(int storeNum); // 등록한 유저보다 빠른 대기순서를 가진 유저의 팀 목록 보여줄 용도
    int addWaiting(int waitNum, String userId, int storeNum, int userPeople, Date waitingDate, String startTime, String enterStatus); // 웨이팅 등록 시 대기열에 추가 및 대기 번호 생성
    int modifyOne(UsersWaitingDto usersWaitingDto); // 웨이팅 등록 후 유저가 인원 수정
    int deleteWaiting(int waitingNum); // 웨이팅 등록 후 유저가 취소

    List<UsersWaitingDto> getWaitingList(int storeNum,int waitNum);

}