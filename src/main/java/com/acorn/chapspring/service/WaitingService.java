package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.WaitingDto;
import com.acorn.chapspring.mapper.WaitingMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class WaitingService {
    @Autowired
    private WaitingMapper waitingMapper;

    boolean addWaiting(WaitingDto waitingDto) {
        return false;
    }

    public void insertUser(WaitingDto WaitingDto) {
        waitingMapper.insertUser(WaitingDto);
    }
    boolean deleteWaiting(int waitingId);
}

// 보완수정해야함