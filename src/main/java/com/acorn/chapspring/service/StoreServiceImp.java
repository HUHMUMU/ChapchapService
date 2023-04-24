package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoreFilterDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.StoretypesDto;
import com.acorn.chapspring.mapper.StoreMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class StoreServiceImp implements StoreService{
    private StoreMapper storeMapper;
    @Override
    public List<StoresDto> storeList(StoreFilterDto storeFilterDto) {
        return null;
    }

    @Override
    public List<StoretypesDto> storeTypesList() {
        return null;
    }

    @Override
    public StoresDto getStore(int storeId) {
        return null;
    }

    @Override
    public List<StoresDto> getFilteredAndSortedStores(StoreFilterDto storeFilterDto) {
//        List<StoresDto> filteredStores = storeMapper.findStoresByFilter(storeFilterDto);
//        List<StoresDto> sortedStores = storeMapper.sortFilteredStores(filteredStores, storeFilterDto.getSortCriteria());
//        return sortedStores;
        return null;
    }

    // 주어진 식당 번호에 해당하는 가게 정보
    @Override
    public StoresDto getStoreByStoreNum(int storeNum) {
        StoresDto stores=storeMapper.findStoreByStoreNum(storeNum);
        return stores;
    }
}
