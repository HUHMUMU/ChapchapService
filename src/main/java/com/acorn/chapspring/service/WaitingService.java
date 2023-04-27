package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.WaitingDto;

import java.util.List;

public interface WaitingService {
    List<WaitingDto> getWaitingList();
    WaitingDto getFastWaiting(int storeNum, String waitingDate, String startTime, int waitNum);
    int addWaiting(WaitingDto waitingDto);
    int modifyWaiting(WaitingDto waitingDto);
    int deleteWaiting(int waitNum, int waitingNum);
}