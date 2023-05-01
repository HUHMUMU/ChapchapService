package com.acorn.chapspring.mapper;
import com.acorn.chapspring.dto.UsersWaitingDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface WaitingMapper {

    UsersWaitingDto findByWaitNum(int waitNum );
    UsersWaitingDto findOne(@Param("storeNum") int storeNum,@Param("userId")String userId );

    List<UsersWaitingDto> getWaitingList(@Param("storeNum") int storeNum,@Param("userId")String userId); // 가게에 현재 등록된 모든 웨이팅 리스트
    int addWaiting(UsersWaitingDto usersWaitingDto); // 웨이팅 등록 시 대기열에 추가 및 대기 번호 생성
    int updatePeople(UsersWaitingDto usersWaitingDto); // 웨이팅 등록 후 유저가 인원 수정
    int deleteByWaitingNum(int waitingNum); // 웨이팅 등록 후 유저가 취소


}