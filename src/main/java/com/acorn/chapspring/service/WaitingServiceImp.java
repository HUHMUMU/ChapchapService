package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.UsersWaitingDto;
import com.acorn.chapspring.mapper.WaitingMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j2
@Service
@RequiredArgsConstructor
public class WaitingServiceImp implements WaitingService {
    private final WaitingMapper waitingMapper;


    @Override
    public UsersWaitingDto detail(int storeNum, String userId) {
        return waitingMapper.findOne(storeNum,userId);
    }

    @Override
    public List<UsersWaitingDto> getWaitingByWaitNum(int storeNum,String userId) {
        return waitingMapper.getWaitingList(  storeNum, userId);
    }
    // 대기 중인 팀 조회

    // 대기 등록
    @Override
    @Transactional
    public int addWaiting(UsersWaitingDto usersWaitingDto) {
        int result = waitingMapper.addWaiting(usersWaitingDto);
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
        int modify = waitingMapper.updateOne(usersWaitingDto);
        return modify;
    }

    // 대기 삭제
    @Override
    @Transactional
    public int remove(int storeNum, String userId) {
        int result = waitingMapper.deleteByWaitingNum(storeNum,userId);
        return result;
    }


}