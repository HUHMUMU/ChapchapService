package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoretypesDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface StoretypeMapper {
    StoretypesDto findByStoreType(int storeNum);// 가게별 업종
}
