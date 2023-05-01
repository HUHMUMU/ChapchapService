package com.acorn.chapspring.service;
import com.acorn.chapspring.dto.StoresWaitingDto;
import com.acorn.chapspring.mapper.StoresWaitingMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class StoresWaitingServiceImp implements StoresWaitingService {
    private StoresWaitingMapper storesWaitingMapper;
    @Override
    public StoresWaitingDto getStoreWaitingByStoreNum(int storeNum) {
        return storesWaitingMapper.getStoreWaitingByStoreNum(storeNum);
    }
    @Override
    public StoresWaitingDto getMaxPeople(int storeNum, int maxPeople) {
        return storesWaitingMapper.getMaxPeopleOne(storeNum, maxPeople);
    }
    @Override
    public StoresWaitingDto getTimeSetup(int storeNum, int timeSetup) {
        return storesWaitingMapper.getTimeSetupOne(storeNum, timeSetup);
    }
    @Override
    public StoresWaitingDto getStoreAds(int storeNum, String storeAds){
        return storesWaitingMapper.getStoreAdsOne(storeNum,storeAds);
    }
}
