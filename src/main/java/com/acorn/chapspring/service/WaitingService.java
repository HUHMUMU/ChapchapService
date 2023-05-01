package com.acorn.chapspring.service;
import com.acorn.chapspring.dto.UsersWaitingDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
public interface WaitingService {

    //List<UsersWaitingDto> findByStoreNumByWaitNumAsc(int storeNum, int waitNum);

    UsersWaitingDto detail(int storeNum,String userId);
    List<UsersWaitingDto> getWaitingByWaitNum( int storeNum,String userId);

    int addWaiting(UsersWaitingDto usersWaitingDto);

    int modifyPeople(UsersWaitingDto usersWaitingDto);

    int remove(int waitingNum);
}