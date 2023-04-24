package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoreFilterDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.StoretypesDto;
import com.acorn.chapspring.dto.TypeClassesDto;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface StoreService {
    List<TypeClassesDto> storeTypesList(); // 가게 타입들 조회
    PageInfo<StoresDto> getFilteredAndSortedStores(StoreFilterDto storeFilterDto, int pageNum, int pageSize);
    // 가게 리스트를 필터링하고 정렬

    StoresDto getStoreByStoreNum(int storeNum);
}
