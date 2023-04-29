package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoreImgsDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface StoreImgMapper {
    List<StoreImgsDto> findImgByStore(int storeNum);
}
