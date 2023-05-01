package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoreManagesDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface StoreManageMapper {
    StoreManagesDto findStoreCall(int storeNum); //가게 전화번호
}
