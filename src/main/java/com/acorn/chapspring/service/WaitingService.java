package com.acorn.chapspring.service;
import com.acorn.chapspring.dto.WaitingDto;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public interface WaitingService {
    List<WaitingDto> getWaitingList(int waitNum, int storeNum);
    WaitingDto getFastWaiting(int storeNum, int waitNum);
    int addWaiting(WaitingDto waitingDto);
    int modifyWaiting(WaitingDto waitingDto);
    int deleteWaiting(int waitNum, int waitingNum);

}