package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.WaitingDto;
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
    // 대기 중인 팀 조회
    @Override
    public List<WaitingDto> getWaitingList(int waitNum, int storeNum) {
        return waitingMapper.getWaitingList(waitNum, storeNum);
    }
    // 대기 중인 팀 중 가장 빠른 팀 조회
    public WaitingDto getFastWaiting(int storeNum, int waitNum) {
        return waitingMapper.getFastWaiting(storeNum, waitNum);
    }

    // 대기 등록
    @Override
    @Transactional
    public int addWaiting(WaitingDto waitingDto) {
        int result = waitingMapper.addWaiting(waitingDto);
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
    public int modifyWaiting(WaitingDto waitingDto) {
        int result = waitingMapper.modifyWaiting(waitingDto);
        if (result > 0) {
            log.info("인원 수정 성공");
        } else {
            log.error("인원 수정 실패");
        }
        return result;
    }

    // 대기 삭제
    @Override
    @Transactional
    public int deleteWaiting(int waitNum, int waitingNum) {
        int result = waitingMapper.deleteWaiting(waitNum, waitingNum);
        if (result > 0) {
            log.info("웨이팅 취소 완료.");
        } else {
            log.error("웨이팅 취소 실패");
        }
        return result;
    }
}