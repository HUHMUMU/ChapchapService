package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoreFilterDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.StoretypesDto;

import java.util.List;

public class StoreServiceImp implements StoreService{
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
}
