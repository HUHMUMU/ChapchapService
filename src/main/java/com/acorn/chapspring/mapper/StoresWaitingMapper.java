package com.acorn.chapspring.mapper;
import com.acorn.chapspring.dto.StoresWaitingDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface StoresWaitingMapper {
    StoresWaitingDto getStoreWaitingByStoreNum(int storeNum);
    StoresWaitingDto getMaxPeopleOne(int storeNum, int maxPeople);
    StoresWaitingDto getTimeSetupOne(int storeNum, int timeSetup);
    StoresWaitingDto getStoreAdsOne(int storeNum, String storeAds);
}
