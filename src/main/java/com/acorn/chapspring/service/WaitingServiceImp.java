package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.UsersWaitingDto;
import com.acorn.chapspring.mapper.WaitingMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Log4j2
@Service
@RequiredArgsConstructor
public class WaitingServiceImp implements WaitingService {
    private final WaitingMapper waitingMapper;
//    @Override
//    public int getFastWaiting(storeNum, waitNum){
//
//        int count=0;
//        for(UsersWaitingDto usersWaitingDto : getWaitingList(storeNum, waitNum)){
//            if(usersWaitingDto.getWaitNum()<waitNum){
//                count++;
//            }else{
//                break;
//            }
//        }
//        return count;
//    }

    @Override
    public int getWaitingCount(int storeNum) {
        return waitingMapper.getWaitingCount(storeNum);
    }
    @Override
    public int getPrevWaitingCount(int storeNum,int waitNum) {
        return waitingMapper.getPrevWaitingCount(storeNum, Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant()), waitNum);
    }
    @Override
    public UsersWaitingDto getWaitingByWaitNum(int storeNum,int waitNum) {
        return waitingMapper.getWaitingByWaitNum(storeNum, waitNum);
    }
    // 대기 중인 팀 조회
    @Override
    public List<UsersWaitingDto> getWaitingList(int storeNum,int waitNum) {
        List<UsersWaitingDto> usersWaitingDtos=waitingMapper.getWaitingList(storeNum, waitNum);
        return waitingMapper.getWaitingList(storeNum,waitNum);
    }
    // 대기 등록
    @Override
    @Transactional
    public int addWaiting(int waitNum, String userId, int storeNum, int userPeople) {
        int result = waitingMapper.addWaiting(
                waitNum,
                userId,
                storeNum,
                userPeople,
                Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant()),
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")),
                "대기"
        );
        System.out.println(result);
        if (result > 0) {
            log.info("웨이팅 등록 완료 했습니다.");
        } else {
            log.error("대기 등록 실패!");
        }
        return result;
    }

    // 대기 수정
    @Override
    @Transactional
    public int modify(UsersWaitingDto usersWaitingDto) {
        int modify = waitingMapper.modifyOne(usersWaitingDto);
        return modify;
    }

    // 대기 삭제
    @Override
    @Transactional
    public int remove(int waitingNum) {
        int result = waitingMapper.deleteWaiting(waitingNum);
        return result;
    }

    @Override
    public UsersWaitingDto detail(int waitingNum) {
        UsersWaitingDto detail= waitingMapper.getFastWaiting(waitingNum);
        return detail;
    }

//    @Override
//    public UsersWaitingDto detail(int waitingNum) {
//        waitingMapper.
//        return detail();
////       chapStoryMapper.updateIncrementViewCountChapNum(chapNum);
//////        chapStoryMapper.updateIncrementLikeChapNum(chapNum);
////        ChapstorysDto detail = chapStoryMapper.findByChapNum(chapNum);
////        return detail;
//    }

//    @Override
//    public int getFastWaiting(int storeNum, int waitNum) {
//        int count=0;
//        for(UsersWaitingDto usersWaitingDto : getWaitingList(storeNum, waitNum)){
//            if(usersWaitingDto.getWaitNum()<waitNum){
//                count++;
//            }else{
//                break;
//            }
//        }
//        return count;
//    } 여기 일단 주석-> 20:27
}