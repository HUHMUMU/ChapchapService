package com.acorn.chapspring.service;
import com.acorn.chapspring.dto.StoresWaitingDto;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface StoresWaitingService {

    StoresWaitingDto getStoreWaitingByStoreNum(int storeNum);
    StoresWaitingDto getMaxPeople(int storeNum, int maxPeople);
    StoresWaitingDto getTimeSetup(int storeNum, int timeSetup);
    StoresWaitingDto getStoreAds(int storeNum, String storeAds);

}
