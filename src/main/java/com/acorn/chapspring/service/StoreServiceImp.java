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
        return null;
    }

    @Override
    @Transactional
    public StoresDto getStoreByStoreNum(int storeNum) {
        StoresDto stores=storeMapper.findByStoreNum(storeNum);
        return stores;
    }
}
