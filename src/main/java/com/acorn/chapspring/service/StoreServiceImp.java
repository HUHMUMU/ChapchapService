package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoreFilterDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.TypeClassesDto;
import com.acorn.chapspring.mapper.StoreMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class StoreServiceImp implements StoreService{
    private StoreMapper storeMapper;

    @Override
    public List<TypeClassesDto> storeTypesList() { // 가게 타입들 조회
        List<TypeClassesDto> storeTypes=storeMapper.findAllType();
        return storeTypes;
    }
    @Override
    public PageInfo<StoresDto> getFilteredAndSortedStores(StoreFilterDto storeFilterDto, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<StoresDto> stores = storeMapper.sortFilteredStores(storeFilterDto);
        return new PageInfo<>(stores);
    }

    // 주어진 식당 번호에 해당하는 가게 정보
    @Override
    public StoresDto getStoreByStoreNum(int storeNum) {
        StoresDto stores=storeMapper.findStoreByStoreNum(storeNum);
        return stores;
    }
}
