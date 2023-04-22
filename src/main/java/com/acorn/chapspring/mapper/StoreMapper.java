package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoreDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StoreMapper {
    StoreDto findByStoreNum(int StoreNum);
}
