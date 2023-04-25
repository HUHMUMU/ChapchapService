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
import java.util.stream.Collectors;

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
    public PageInfo<StoresDto> getFilteredStores(StoreFilterDto storeFilterDto) {
        // PageHelper를 사용하여 페이지네이션 설정
        PageHelper.startPage(storeFilterDto.getPageNumber(), storeFilterDto.getPageSize(), storeFilterDto.getOrderBy());

        // 필터 및 정렬 조건에 맞는 가게 목록 조회
        List<StoresDto> stores = storeMapper.findStoresByFilter(storeFilterDto);

        // PageInfo 객체 생성하여 결과 반환
        return new PageInfo<>(stores);
    }

    // 주어진 식당 번호에 해당하는 가게 정보
    @Override
    public StoresDto getStoreByStoreNum(int storeNum) {
        StoresDto stores=storeMapper.findStoreByStoreNum(storeNum);
        return stores;
    }
}
