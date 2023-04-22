package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoreFilterDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.StoretypesDto;

import java.util.List;

public interface StoreService {
    List<StoresDto> storeList(StoreFilterDto storeFilterDto); // 가게 리스트 조회
    List<StoretypesDto> storeTypesList(); // 가게 종류 조회
    StoresDto getStore(int storeId); // 가게 정보 조회
    List<StoresDto> getFilteredAndSortedStores(StoreFilterDto storeFilterDto);
    // 가게 리스트를 필터링하고 정렬

}
