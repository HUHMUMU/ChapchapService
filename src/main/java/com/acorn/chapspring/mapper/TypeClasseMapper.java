package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.TypeClassesDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface TypeClasseMapper {
    TypeClassesDto findByStoreType(int categoryNum);
}
