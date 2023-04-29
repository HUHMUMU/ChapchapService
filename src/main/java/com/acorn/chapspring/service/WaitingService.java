package com.acorn.chapspring.service;
import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.UsersWaitingDto;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
@Service
public interface WaitingService {

    //List<UsersWaitingDto> findByStoreNumByWaitNumAsc(int storeNum, int waitNum);

    int getWaitingCount(int storeNum);
    int getPrevWaitingCount(int storeNum, int waitNum);

    UsersWaitingDto getWaitingByWaitNum(int storeNum, int waitNum);
    List<UsersWaitingDto> getWaitingList(int storeNum, int waitNum);

    int addWaiting(int waitNum, String userId, int storeNum, int userPeople);
    int remove(int waitingNum);
    UsersWaitingDto detail(int waitingNum);


    int modify(UsersWaitingDto usersWaitingDto);

}